//
//  Stepper.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 14.08.2021.
//

import UIKit

final class Stepper: UIView {
    
    var value = 0 {
        didSet {
            valueChanged?(value)
            if value == maxLimit {
                incrementButton.isEnabled = false
            } else {
                incrementButton.isEnabled = true
            }
        }
    }
    var valueChanged: ((Int) -> Void)?
    
    private var maxLimit = 0
    
    private weak var decrementButton: UIButton!
    private weak var incrementButton: UIButton!
    
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
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.spacing = 65
            stack.pinTo(self)
            
            return stack
        }()
        
        decrementButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            button.tintColor = UIColor(red: 0.296, green: 0.617, blue: 0.34, alpha: 1)
            button.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
            stack.addArrangedSubview(button)
            
            return button
        }()
        
        incrementButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            button.tintColor = UIColor(red: 0.296, green: 0.617, blue: 0.34, alpha: 1)
            button.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
            stack.addArrangedSubview(button)
            
            return button
        }()
    }
    
    @objc private func decrementValue() {
        value -= 1
    }
    
    @objc private func incrementValue() {
        value += 1
    }
}
