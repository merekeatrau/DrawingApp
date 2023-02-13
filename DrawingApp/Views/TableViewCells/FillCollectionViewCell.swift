//
//  FillCollectionViewCell.swift
//  DrawingApp
//
//  Created by Mereke on 10.02.2023.
//

import UIKit

class FillCollectionViewCell: UICollectionViewCell {
    static let identifier = "FillCollectionViewCell"
    
    var fillButtonTapped: ((Bool) -> ())?
    
    let toggleBar: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .systemBlue
        return toggle
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let titleToggleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        toggleBar.addTarget(self, action: #selector(toggleValueChanged), for: .valueChanged)
    }
    
    @objc func toggleValueChanged(_ sender: UISwitch) {
        fillButtonTapped?(sender.isOn)
        print(sender.isOn)
    }
    
    private func setupViews() {
        addSubview(titleToggleStackView)
        titleToggleStackView.addArrangedSubview(titleLabel)
        titleToggleStackView.addArrangedSubview(toggleBar)
        
        titleToggleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleToggleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleToggleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleToggleStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleToggleStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

