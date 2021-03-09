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
    
    func setLineColor(_ newColor: CGColor) {
        lineColor = newColor
    }
    
    func setLineWidth(_ newWidth: Float) {
        lineWidth = CGFloat(newWidth)
    }
    
    var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setLineCap(.butt)
            context.setStrokeColor(line.color)
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let line  = Line.init(color: lineColor, width: lineWidth, position: [])
        lines.append(line)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.position.append(position)
        lines.append(lastLine)
        setNeedsDisplay()
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
