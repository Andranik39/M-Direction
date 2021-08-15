//
//  HistoryButton.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 08.08.2021.
//

import UIKit

final class HistoryButton: UIControl {
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    var titleColor: UIColor? {
        didSet {
            label.textColor = titleColor
        }
    }
    var color: UIColor? {
        didSet {
            container.backgroundColor = color
        }
    }
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    private var label: UILabel!
    private var container: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        container = {
            let view = UIView()
            view.pinTo(self)
            
            return view
        }()
        
        label = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(label)
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            
            return label
        }()
    }
}
