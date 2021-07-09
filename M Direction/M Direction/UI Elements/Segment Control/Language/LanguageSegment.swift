//
//  LanguageSegment.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.06.2021.
//

import UIKit

final class LanguageSegment: Segment {
    
    private let container = UIStackView()
    private let image = UIImageView()
    private let shortcut = UILabel()
    
    override func setupSubviews() {
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 6
        container.pinTo(self)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        image.backgroundColor = .systemPink
//        image.layer.borderWidth = 2
//        image.layer.cornerRadius = 20
//        image.layer.cornerCurve = .circular
        container.addArrangedSubview(image)
        
        shortcut.translatesAutoresizingMaskIntoConstraints = false
        shortcut.font = .systemFont(ofSize: 16)
        container.addArrangedSubview(shortcut)
        
        deselect()
    }
    
    override func select() {
        delegate?.segmentDidSelect(self)
//        image.backgroundColor = .cyan
//        image.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    override func deselect() {
//        image.backgroundColor = .systemPink
//        image.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func setup(with model: LanguageModel) {
        shortcut.text = model.shortcut
        image.image = model.image
    }
}
