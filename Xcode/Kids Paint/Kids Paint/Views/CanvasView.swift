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
    fileprivate var currentTool: Tool = .penTool
    
    func setLineColor(_ newColor: CGColor) {
        lineColor = newColor
    }
    
    func setLineWidth(_ newWidth: Float) {
        lineWidth = CGFloat(newWidth)
    }
    
    func setDrawingTool(_ newTool: Tool) {
        currentTool = newTool
    }
    
    private var lines = [Line]()
    private var temporaryDrag = Drag()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            
            context.setLineCap(line.cap)
            context.setStrokeColor(line.color)
            context.setAlpha(1.0)
            context.setLineWidth(line.width)
            
            if line.tool == .penTool {
                for (i, p) in line.position.enumerated() {
                    if i == 0 {
                        context.move(to: p)
                    }
                    else {
                        context.addLine(to: p)
                    }
                }
            } else {
                let rect = createRect(from: line.position[0], to: line.position[1])
                if line.tool == .rectTool {
                    context.addRect(rect)
                    context.strokePath()
                }
                else if line.tool == .ovalTool {
                    context.addEllipse(in: rect)
                    context.strokePath()
                }
            }
            
            
            context.strokePath()
        }
        
        // draw temporary shapes while dragging
        guard (temporaryDrag.start != nil),
              (temporaryDrag.moved != nil) else { return }
        
        context.setLineCap(.square)
        context.setStrokeColor(lineColor)
        context.setAlpha(0.5)
        context.setLineWidth(lineWidth)
        
        let rect = createRect(from: temporaryDrag.start!, to: temporaryDrag.moved!)
        
        if currentTool == .rectTool {
            context.addRect(rect)
            context.strokePath()
        }
        else if currentTool == .ovalTool {
            context.addEllipse(in: rect)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch currentTool {
        case .rectTool,
             .ovalTool:
            temporaryDrag.start = touches.first?.location(in: self)
            break
        case .penTool:
            lines.append(Line.init(color: lineColor, width: lineWidth, tool: .penTool, position: [], cap: .round))
            break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch currentTool {
        case .rectTool,
             .ovalTool:
            temporaryDrag.moved = touches.first?.location(in: self)
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
        if currentTool == .rectTool || currentTool == .ovalTool {
            guard (temporaryDrag.start != nil),
                  (temporaryDrag.moved != nil) else { return }
            lines.append(Line(color: lineColor, width: lineWidth, tool: currentTool, position: [temporaryDrag.start!, temporaryDrag.moved!], cap: .square))
            temporaryDrag.clear()
            setNeedsDisplay()
        }
    }
    
    private func createRect(from start: CGPoint, to end: CGPoint) -> CGRect {
        return CGRect(x: start.x, y: start.y, width: (end.x - start.x), height: (end.y - start.y))
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
