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
    
    var complition: ((Int) -> Void)?
    
    var container: UIStackView!
    var indicator: UIView?
    private var indicatorCenterX: NSLayoutConstraint?
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
        container = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
//        stack.distribution = .equalSpacing
            stack.pinTo(self)
            
            return stack
        }()
    }
    
    func setupSubviews() {}
    
    func extendSelection() {}
}

extension SegmentControl: SegmentControlDelegate {
    func segmentDidSelect(_ segment: Segment) {
        selectedSegment?.deselect()
        indicatorCenterX?.isActive = false
//        UIView.animate(withDuration: 0.25) {
            self.selectedSegment = segment
            self.indicatorCenterX = self.indicator?.centerXAnchor.constraint(equalTo: segment.centerXAnchor)
            self.indicatorCenterX?.isActive = true
            self.extendSelection()
//            self.layoutSubviews()
//        }
        guard let value = segment.value else { return }
        complition?(value)
    }
}
