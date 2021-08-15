//
//  ConfirmationAlert.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 12.08.2021.
//

import UIKit

final class ConfirmationAlert: UIView {
    
    var top: NSLayoutYAxisAnchor? {
        didSet {
            if let top = top {
                background.topAnchor.constraint(equalTo: top, constant: 80).isActive = true
            }
        }
    }
    private var background: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let _: UIView = {
            let cover = UIView()
            cover.backgroundColor = .black
            cover.alpha = 0.4
            cover.pinTo(self)

            return cover
        }()
        
        background = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            view.layer.cornerRadius = 14
            view.pinTo(self, leading: 15, top: nil, trailing: -15, bottom: nil)
            return view
        }()
        
        let _: UIButton = {
            let button = UIButton(type: .system)
            button.tintColor = UIColor(red: 0.296, green: 0.617, blue: 0.34, alpha: 1)
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
            button.pinTo(background, leading: nil, top: 15, trailing: -15, bottom: nil)
            
            return button
        }()
        
        let shortcut: UIImageView = {
            let shortcut = UIImageView()
            shortcut.image = UIImage(named: "Done")
            shortcut.pinTo(background, leading: nil, top: 30, trailing: nil, bottom: nil)
            shortcut.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
            
            return shortcut
        }()
        
        let title: UILabel = {
            let label = UILabel()
            label.text = "Շնորհակալություն,\nերթուղին հաստատված է"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 22)
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.numberOfLines = 0
            label.pinTo(background, leading: nil, top: nil, trailing: nil, bottom: nil)
            label.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: shortcut.bottomAnchor, constant: 17).isActive = true

            return label
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.text = "Դուք կստանաք ծանուցում\nպատվերի դեպքում"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.numberOfLines = 0
            label.pinTo(background, leading: nil, top: nil, trailing: nil, bottom: -30)
            label.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12).isActive = true

            return label
        }()
    }
    
    @objc private func closeView() {
        removeFromSuperview()
    }
}
