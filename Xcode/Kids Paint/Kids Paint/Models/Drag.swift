//
//  Drag.swift
//  Kids Paint
//
//  Created by Oliver Völke on 15.03.21.
//

import UIKit

public struct Drag {
    var start: CGPoint?
    var moved: CGPoint?
    
    mutating func clear() {
        self.start = nil
        self.moved = nil
    }
}
