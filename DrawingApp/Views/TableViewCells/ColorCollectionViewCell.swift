//
//  ColorCollectionViewCell.swift
//  DrawingApp
//
//  Created by Mereke on 10.02.2023.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    static let identifier = "ColorCollectionViewCell"

    private let stackView = UIStackView()
    private let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .brown, .black]
    var colorButtonTapped: ((UIColor) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        for color in colors {
            let colorButton = UIButton(type: .system)
            colorButton.backgroundColor = color
            colorButton.layer.cornerRadius = 4
            colorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(colorButton)
        }
    }

    @objc func colorButtonTapped(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        colorButtonTapped?(color)
    }
}

