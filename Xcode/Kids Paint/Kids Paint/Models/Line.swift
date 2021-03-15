//
//  CanvasLine.swift
//  Kids Paint
//
//  Created by Oliver Völke on 26.02.21.
//

import UIKit

public struct Line {
    let color: CGColor
    let width: CGFloat
    let tool: Tool
    var position: [CGPoint]
    var cap: CGLineCap
}
