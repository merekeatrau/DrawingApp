//
//  CanvasView.swift
//  DrawingApp
//
//  Created by Mereke on 08.02.2023.
//

import UIKit

class CanvasView: UIView {
    private var shape: Shape?
    private var path = UIBezierPath()
    private var shapes = [(path: UIBezierPath, color: UIColor, fill: Bool)]()
    private var currentShape = [UIBezierPath]()
    private var startingPoint: CGPoint?
    private var selectedColor = UIColor.black
    private var isFilled = false
    
    override func draw(_ rect: CGRect) {
        for shape in shapes {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = shape.path.cgPath
            shapeLayer.strokeColor = shape.color.cgColor
            if shape.fill {
                shapeLayer.fillColor = shape.color.cgColor
            }
            else {
                shapeLayer.fillColor = UIColor.clear.cgColor
            }
            shapeLayer.lineWidth = 3
            layer.addSublayer(shapeLayer)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        guard let point = point else { return }
        startingPoint = point
        currentShape.append(UIBezierPath())
        currentShape.last?.move(to: point)
        shapes.append((path: currentShape.last!, color: selectedColor, fill: isFilled))
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        guard let point = point else { return }
        switch shape {
        case .pencil:
            currentShape.last?.addLine(to: point)
            setNeedsDisplay()
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let endPoint = touches.first?.location(in: self)
        guard let endPoint = endPoint, let startPoint = startingPoint else { return }
        switch shape {
        case .circle:
            let center = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
            let radius = max(abs(endPoint.x - startPoint.x), abs(endPoint.y - startPoint.y)) / 2
            currentShape.last?.append(UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true))
        case .rectangle:
            let origin = CGPoint(x: min(startPoint.x, endPoint.x), y: min(startPoint.y, endPoint.y))
            let size = CGSize(width: abs(endPoint.x - startPoint.x), height: abs(endPoint.y - startPoint.y))
            currentShape.last?.append(UIBezierPath(rect: CGRect(origin: origin, size: size)))
        case .triangle:
            currentShape.last?.move(to: CGPoint(x: startPoint.x, y: endPoint.y))
            currentShape.last?.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
            currentShape.last?.addLine(to: CGPoint(x: (startPoint.x + endPoint.x) / 2, y: startPoint.y))
            currentShape.last?.close()
        case .line:
            currentShape.last?.move(to: startPoint)
            currentShape.last?.addLine(to: endPoint)
        default:
            break
        }
        setNeedsDisplay()
    }
}

extension CanvasView {
    func reset() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        shapes.removeAll()
        currentShape.removeAll()
        setNeedsDisplay()
    }
    
    func changeColor(to color: UIColor) {
        selectedColor = color
    }
    
    func undo() {
        if !shapes.isEmpty {
            while let lastSublayer = layer.sublayers?.last {
                lastSublayer.removeFromSuperlayer()
            }
            shapes.removeLast()
            currentShape = []
            setNeedsDisplay()
        }
    }
    
    func fill(_ isOn: Bool) {
        isFilled = isOn
    }
    
    func selectShape(_ selectedShape: Shape) {
        shape = selectedShape
    }
}





