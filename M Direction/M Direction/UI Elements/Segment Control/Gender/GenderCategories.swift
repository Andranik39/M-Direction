//
//  GenderControl.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class GenderControl: SegmentControl {
    override func setupSubviews() {
        indicator = UIView()
        guard let indicator = indicator else { return }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
        addSubview(indicator)
        indicator.widthAnchor.constraint(equalToConstant: 105).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        indicator.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 8).isActive = true
        
        container.spacing = 41
        
        for model in genderCategories {
            let segment = GenderSegment()
            segment.delegate = self
            segment.setup(with: model)
            container.addArrangedSubview(segment)
            
            if model.value == .male {
                segment.select()
            }
        }
    }
}
