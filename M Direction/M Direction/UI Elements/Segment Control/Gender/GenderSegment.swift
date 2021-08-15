//
//  GenderSegments.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class GenderSegment: Segment {
    
    private let title = UILabel()
    
    override func setupSubviews() {
        title.font = .systemFont(ofSize: 20)
        title.pinTo(self)
    }
    
    override func select() {
        delegate?.segmentDidSelect(self)
    }
    
    func setup(with model: GenderCategories) {
        title.text = model.title
        value = model.value.rawValue
    }
}
