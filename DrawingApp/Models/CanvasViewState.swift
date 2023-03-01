//
//  CanvasViewState.swift
//  DrawingApp
//
//  Created by Mereke on 01.03.2023.
//

import Foundation
import UIKit

class CanvasViewState {
    var path = [UIBezierPath]()
    var fill: Bool
    var color: UIColor
    var shape: ShapeType

    init(path: [UIBezierPath], fill: Bool, color: UIColor, shape: ShapeType) {
        self.path = path
        self.fill = fill
        self.color = color
        self.shape = shape
    }
}

