//
//  UserSegment.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 18.06.2021.
//

import UIKit

final class UserSegment: Segment {
    
    private let title = UILabel()
    
    override func setupSubviews() {
        title.font = .systemFont(ofSize: 26)
        title.pinTo(self)
    }
    
    override func select() {
        delegate?.segmentDidSelect(self)
    }
    
    func setup(with model: UserCategories) {
        title.text = model.title
        value = model.value.rawValue
    }
}
