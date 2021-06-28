//
//  Segment.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.06.2021.
//

import UIKit

class Segment: UIView {
    
    var delegate: SegmentControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        addGesture()
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        select()
    }
    
    func setupSubviews() {}
    
    func select() {}
    
    func deselect() {}
}
