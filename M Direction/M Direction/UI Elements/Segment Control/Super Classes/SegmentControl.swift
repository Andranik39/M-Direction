//
//  CustomSegmentControl.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.06.2021.
//

import UIKit

protocol SegmentControlDelegate {
    func segmentDidSelect(_ segment: Segment)
}

class SegmentControl: UIView {
    
    var container = UIStackView()
    var indicator: UIView?
    var indicatorCenterX: NSLayoutConstraint?
    private(set) var selectedSegment: Segment?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setupSubviews()
    }
    
    private func setupStackView() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .horizontal
        container.alignment = .center
        addSubview(container)
        container.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupSubviews() {}
}

extension SegmentControl: SegmentControlDelegate {
    func segmentDidSelect(_ segment: Segment) {
        selectedSegment?.deselect()
        indicatorCenterX?.isActive = false
        selectedSegment = segment
        indicatorCenterX = indicator?.centerXAnchor.constraint(equalTo: segment.centerXAnchor)
        indicatorCenterX?.isActive = true
    }
}
