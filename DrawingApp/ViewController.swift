//
//  ViewController.swift
//  DrawingApp
//
//  Created by Mereke on 08.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let canvasView = CanvasView()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        return button
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Suret salu"
        view.backgroundColor = .white
        collectionView.register(ToolsCollectionViewCell.self, forCellWithReuseIdentifier: ToolsCollectionViewCell.identifier)
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
        collectionView.register(FillCollectionViewCell.self, forCellWithReuseIdentifier: FillCollectionViewCell.identifier)
        collectionView.register(ReturnCollectionViewCell.self, forCellWithReuseIdentifier: ReturnCollectionViewCell.identifier)
        canvasView.frame = view.bounds
        setupViews()
        setConstrainsts()
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    func setupViews() {
        view.addSubview(canvasView)
        view.addSubview(resetButton)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setConstrainsts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @objc func resetButtonTapped() {
        canvasView.reset()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToolsCollectionViewCell.identifier, for: indexPath) as! ToolsCollectionViewCell
            cell.backgroundColor = .clear
            cell.didSelectShape = { shape in
                self.canvasView.selectShape(shape)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FillCollectionViewCell.identifier, for: indexPath) as! FillCollectionViewCell
            cell.backgroundColor = .clear
            cell.fillButtonTapped = { isOn in
                self.canvasView.fill(isOn)
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            cell.backgroundColor = .clear
            cell.colorButtonTapped = { color in
                self.canvasView.changeColor(to: color)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReturnCollectionViewCell.identifier, for: indexPath) as! ReturnCollectionViewCell
            cell.didReturnTapped = {
                self.canvasView.undo()
            }
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 64)
    }
    
}
