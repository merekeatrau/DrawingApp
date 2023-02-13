//
//  ToolsCollectionViewCell.swift
//  DrawingApp
//
//  Created by Mereke on 10.02.2023.
//

import UIKit

class ToolsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ToolsCollectionViewCell"
    
    private let stackView = UIStackView()
    private let circleButton = UIButton(type: .system)
    private let rectangleButton = UIButton(type: .system)
    private let triangleButton = UIButton(type: .system)
    private let pencilButton = UIButton(type: .system)
    private let lineButton = UIButton(type: .system)

    var didSelectShape: ((Shape) -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        circleButton.setImage(UIImage(systemName: "circle"), for: .normal)
        circleButton.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
        
        rectangleButton.setImage(UIImage(systemName: "rectangle"), for: .normal)
        rectangleButton.addTarget(self, action: #selector(rectangleButtonTapped), for: .touchUpInside)
        
        triangleButton.setImage(UIImage(systemName: "triangle"), for: .normal)
        triangleButton.addTarget(self, action: #selector(triangleButtonTapped), for: .touchUpInside)
        
        pencilButton.setImage(UIImage(systemName: "paintbrush.pointed"), for: .normal)
        pencilButton.addTarget(self, action: #selector(pencilButtonTapped), for: .touchUpInside)
        
        lineButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        lineButton.addTarget(self, action: #selector(lineButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(circleButton)
        stackView.addArrangedSubview(rectangleButton)
        stackView.addArrangedSubview(triangleButton)
        stackView.addArrangedSubview(pencilButton)
        stackView.addArrangedSubview(lineButton)
        
        layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func circleButtonTapped() {
        didSelectShape?(.circle)
    }
    
    @objc func rectangleButtonTapped() {
        didSelectShape?(.rectangle)
    }
    
    @objc func triangleButtonTapped() {
        didSelectShape?(.triangle)
    }
    
    @objc func pencilButtonTapped() {
        didSelectShape?(.pencil)
    }
    
    @objc func lineButtonTapped() {
        didSelectShape?(.line)
    }
    
}

