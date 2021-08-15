//
//  Weekdays.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 14.08.2021.
//

import UIKit

final class Weekdays: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .firstBaseline
            stack.distribution = .fillEqually
            stack.pinTo(self)
            
            return stack
        }()
        
        for item in ["Ե", "Ե", "Չ", "Հ", "Ու", "Շ", "Շ"] {
            let view: UIView = {
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 7
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
                stack.addArrangedSubview(view)
                
                return view
            }()
            
            let _: UILabel = {
                let label = UILabel()
                label.text = item
                label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
//                label.font = .systemFont(ofSize: 14)
                label.pinTo(view, leading: nil, trailing: nil)
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

                return label
            }()
        }
    }
}
