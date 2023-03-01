//
//  CanvasViewCaretaker.swift
//  DrawingApp
//
//  Created by Mereke on 01.03.2023.
//

import Foundation

class CanvasViewCaretaker {
    private var shapes: [CanvasViewState] = []

    func addStates(_ shape: CanvasViewState) {
        shapes.append(shape)
    }

    func getStates() -> [CanvasViewState?] {
        return shapes
    }

    func removeAllStates() {
        shapes.removeAll()
    }

    func removeLastState() {
        shapes.removeLast()
    }
}
