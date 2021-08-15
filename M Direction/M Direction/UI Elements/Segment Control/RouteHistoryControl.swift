//
//  RouteHistoryControl.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 06.08.2021.
//

import UIKit

final class RouteHistoryControl: SegmentControl {
    
    private var indicatorWidth: NSLayoutConstraint?
    
    override func setupSubviews() {
        backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        layer.cornerRadius = 13
        container.spacing = 23
        container.distribution = .equalSpacing
        container.removeFromSuperview()
        container.pinTo(self, leading: 16, top: 13, trailing: -16, bottom: -13)
        
        indicator = {
            let indicator = CapsuleView()
            indicator.translatesAutoresizingMaskIntoConstraints = false
            insertSubview(indicator, at: 0)
            indicator.heightAnchor.constraint(equalTo: heightAnchor, constant: -6).isActive = true
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            return indicator
        }()
        
        for (index, model) in routeHistoryCategories.enumerated() {
            let state = RouteStateSegment()
            state.delegate = self
            state.setup(with: model)
            container.addArrangedSubview(state)
            
            if index == 0 {
                state.select()
            }
        }
    }
    
    override func extendSelection() {
        guard let segment = selectedSegment as? RouteStateSegment, let indicator = indicator else { return }
//        indicator.layer.cornerRadius = indicator.frame.height / 2
        indicatorWidth?.isActive = false
        indicatorWidth = indicator.widthAnchor.constraint(equalTo: segment.widthAnchor, constant: 20)
        indicatorWidth?.isActive = true
        
        if segment.value == 2 {
            indicator.backgroundColor = UIColor(red: 0.95, green: 0.253, blue: 0.253, alpha: 1)
        } else {
            indicator.backgroundColor = UIColor(red: 0.638, green: 0.933, blue: 0.845, alpha: 1)
        }
    }
}

final class CapsuleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = min(bounds.height, bounds.width) / 2
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
