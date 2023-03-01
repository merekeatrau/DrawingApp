//
//  CanvasView.swift
//  DrawingApp
//
//  Created by Mereke on 08.02.2023.
//

import UIKit

class CanvasView: UIView {
    private var shape: ShapeType?
    private var currentShape = [UIBezierPath]()
    private var startingPoint: CGPoint?
    private var selectedColor = UIColor.black
    private var isFilled = false
    private var caretaker = CanvasViewCaretaker()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        guard let point = point else { return }
        startingPoint = point
        currentShape.append(UIBezierPath())
        currentShape.last?.move(to: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        guard let point = point else { return }
        switch shape {
        case .pencil:
            let path = UIBezierPath()
            currentShape.last?.addLine(to: point)
            draw()
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let endPoint = touches.first?.location(in: self)
        guard let endPoint = endPoint, let startPoint = startingPoint else { return }
        switch shape {
        case .circle:
            let center = CGPoint(x: (startPoint.x + endPoint.x) / 2,
                                 y: (startPoint.y + endPoint.y) / 2)
            let radius = max(abs(endPoint.x - startPoint.x), abs(endPoint.y - startPoint.y)) / 2
            currentShape.last?.append(UIBezierPath(arcCenter: center,
                                                   radius: radius,
                                                   startAngle: 0,
                                                   endAngle: 2 * .pi,
                                                   clockwise: true))
        case .rectangle:
            let origin = CGPoint(x: min(startPoint.x, endPoint.x),
                                 y: min(startPoint.y, endPoint.y))
            let size = CGSize(width: abs(endPoint.x - startPoint.x),
                              height: abs(endPoint.y - startPoint.y))
            currentShape.last?.append(UIBezierPath(rect: CGRect(origin: origin, size: size)))
        case .triangle:
            currentShape.last?.move(to: CGPoint(x: startPoint.x,
                                                y: endPoint.y))
            currentShape.last?.addLine(to: CGPoint(x: endPoint.x,
                                                   y: endPoint.y))
            currentShape.last?.addLine(to: CGPoint(x: (startPoint.x + endPoint.x) / 2,
                                                   y: startPoint.y))
            currentShape.last?.close()
        case .line:
            currentShape.last?.move(to: startPoint)
            currentShape.last?.addLine(to: endPoint)
        default:
            break
        }
        draw()
        saveState()
        setNeedsDisplay()
        currentShape = [UIBezierPath]()
    }
}

extension CanvasView {
    private func draw(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = currentShape.last?.cgPath
        shapeLayer.lineWidth = 2
        if !isFilled {
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = selectedColor.cgColor
        } else {
            shapeLayer.fillColor = selectedColor.cgColor
            shapeLayer.strokeColor = selectedColor.cgColor
        }
        self.layer.addSublayer(shapeLayer)
    }

    private func saveState() {
        if let shape = shape {
            let state = CanvasViewState(path: currentShape, fill: isFilled, color: selectedColor, shape: shape)
            caretaker.addStates(state)
        }
    }

    func reset() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        caretaker.removeAllStates()
        currentShape = []
        setNeedsDisplay()
        print(caretaker.getStates().count)
    }

    func undo() {
        if !caretaker.getStates().isEmpty {
            print(caretaker.getStates().count)
            if let lastSublayer = layer.sublayers?.last {
                lastSublayer.removeFromSuperlayer()
            }
            caretaker.removeLastState()
            currentShape = []
            setNeedsDisplay()
        }
        print(caretaker.getStates().count)

    }

    func changeColor(to color: UIColor) {
        selectedColor = color
    }
    
    func fill(_ isOn: Bool) {
        isFilled = isOn
    }
    
    func selectShape(_ selectedShape: ShapeType) {
        shape = selectedShape
    }
}
