//
//  UserTypes.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 18.06.2021.
//

import UIKit

final class UserTypeControl: SegmentControl {
    override func setupSubviews() {
        indicator = UIView()
        guard let indicator = indicator else { return }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
        addSubview(indicator)
        indicator.widthAnchor.constraint(equalToConstant: 105).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        indicator.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 8).isActive = true
        
        container.spacing = 64
        
        for model in userCategories {
            let segment = UserSegment()
            segment.delegate = self
            segment.setup(with: model)
            container.addArrangedSubview(segment)
            
            if model.value == .passenger {
                segment.select()
            }
        }
    }
}
