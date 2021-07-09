//
//  Support.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 05.07.2021.
//

import UIKit

extension UIView {
    func pinTo(_ view: UIView, leading: CGFloat? = 0, top: CGFloat? = 0, trailing: CGFloat? = 0, bottom: CGFloat? = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        if let constant = leading {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        }
        if let constant = top {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        }
        if let constant = trailing {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant).isActive = true
        }
        if let constant = bottom {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
        }
    }
}
