//
//  CanvasView.swift
//  Kids Paint
//
//  Created by Oliver Völke on 26.02.21.
//

import UIKit

class CanvasView : UIView {
    
    fileprivate var lineColor: CGColor = UIColor.black.cgColor
    fileprivate var lineWidth: CGFloat = 10
    fileprivate var drawingTool: Tool = .penTool
    
    func setLineColor(_ newColor: CGColor) {
        lineColor = newColor
    }
    
    func setLineWidth(_ newWidth: Float) {
        lineWidth = CGFloat(newWidth)
    }
    
    func setDrawingTool(_ newTool: Tool) {
        drawingTool = newTool
    }
    
    private var lines = [Line]()
    private var tempRect: [CGPoint]?
    private var tempFirstTouch: CGPoint?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setLineCap(line.cap)
            context.setStrokeColor(line.color)
            context.setAlpha(1.0)
            context.setLineWidth(line.width)
            for (i, p) in line.position.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }
                else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        // draw temporary rect
        if tempRect != nil {
            context.setLineCap(.square)
            context.setStrokeColor(lineColor)
            context.setAlpha(0.5)
            context.setLineWidth(lineWidth)
            for (i, p) in tempRect!.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }
                else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch drawingTool {
        case .rectTool,
             .ovalTool:
            tempFirstTouch = touches.first?.location(in: self)
            break
        case .penTool:
            let line = Line.init(color: lineColor, width: lineWidth, position: [], cap: .round)
            lines.append(line)
            break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch drawingTool {
        case .rectTool,
             .ovalTool:
            if let max = touches.first?.location(in: self),
               let min = tempFirstTouch {
                tempRect = [min,
                            CGPoint(x: min.x, y: max.y),
                            max,
                            CGPoint(x: max.x, y: min.y),
                            min]
            }
            break
        case .penTool:
                guard let position = touches.first?.location(in: self) else { return }
                guard var lastLine = lines.popLast() else { return }
                lastLine.position.append(position)
                lines.append(lastLine)
            break
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch drawingTool {
        case .rectTool,
             .ovalTool:
            if let rect = tempRect {
                lines.append(Line(color: lineColor, width: lineWidth, position: rect, cap: .square))
                tempRect = nil
                tempFirstTouch = nil
                setNeedsDisplay()
            }
            break
        case .penTool:
                print("touchesEnded: penTool")
            break
        }
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
}
