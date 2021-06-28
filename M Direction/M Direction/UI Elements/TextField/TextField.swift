//
//  UserType.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 18.06.2021.
//

import UIKit

final class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        primarySetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        primarySetup()
    }
    
    private func primarySetup() {
        backgroundColor = UIColor(red: 0.728, green: 0.771, blue: 0.721, alpha: 0.5)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 25
        layer.cornerCurve = .circular
        tintColor = .black
        font = .systemFont(ofSize: 18)
        
        textAlignment = .center
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var result = super.textRect(forBounds: bounds)
        result.origin.x += 25
        result.size.width -= 50
        return result
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var result = super.editingRect(forBounds: bounds)
        result.origin.x += 25
        result.size.width -= 50
        return result
    }
}
