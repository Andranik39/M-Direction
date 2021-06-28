//
//  GenderSegments.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class GenderSegment: Segment {
    
    private let title = UILabel()
    private(set) var state: GenderCategories.Gender?
    
    override func setupSubviews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 20)
        addSubview(title)
        
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override func select() {
        delegate?.segmentDidSelect(self)
    }
    
    func setup(with model: GenderCategories) {
        title.text = model.title
        state = model.value
    }
}