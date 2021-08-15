//
//  GetRoute.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 08.07.2021.
//

import UIKit

final class SingedIn: Account {
    override func setupSubviews() {
        title = "Ընտրել երթուղին"
        
        let _: Button = {
           let button = Button()
            button.setup(with: "Ընտրել երթուղին")
            button.addTarget(self, action: #selector(getRoute), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            button.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
            
            return button
        }()
    }
    
    @objc private func getRoute() {
        print(1)
    }
}
