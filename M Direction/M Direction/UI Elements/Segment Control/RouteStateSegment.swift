//
//  RouteStateSegment.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 06.08.2021.
//

import UIKit

final class RouteStateSegment: Segment {
    
    var textColor: UIColor? {
        didSet {
            title.textColor = textColor
        }
    }
    private let title = UILabel()
    
    override func setupSubviews() {
        title.font = .systemFont(ofSize: 16)
        title.pinTo(self)
    }
    
    override func select() {
        delegate?.segmentDidSelect(self)
        if value == 2 {
            textColor = .white
        }
    }
    
    override func deselect() {
        textColor = nil
    }
    
    func setup(with model: RouteHistoryCategories) {
        title.text = model.title
        value = model.value.rawValue
    }
}
