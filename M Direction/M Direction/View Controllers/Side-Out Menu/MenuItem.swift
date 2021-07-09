//
//  MenuItem.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 05.07.2021.
//

import UIKit

class MenuItem: UITableViewCell {
    
    static var identifier = "MenuItem"
    
    private var shortcut: UIView!
    private var title: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
//    @available(iOS 14.0, *)
//    override func updateConfiguration(using state: UICellConfigurationState) {
//        var bgc = UIBackgroundConfiguration.listPlainCell().updated(for: state)
//
//        if state.isHighlighted || state.isSelected {
//            bgc.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.65)
//        } else {
//            bgc.backgroundColor = .clear
//        }
//        backgroundConfiguration = bgc
//    }

    private func setupSubviews() {
        let background: UIView = {
            let background = UIView()
            background.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)

            return background
        }()
        backgroundView = background

        let highlighted: UIView = {
            let highlighted = UIView()
            highlighted.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.65)

            return highlighted
        }()
        selectedBackgroundView = highlighted
        
        shortcut = {
            let shortcut = UIView()
            shortcut.backgroundColor = .systemGreen
            shortcut.pinTo(contentView, leading: 15, top: 5, trailing: nil, bottom: -5)
//            shortcut.image = UIImage(systemName: "gear")
//            shortcut.tintColor = UIColor(red: 0.165, green: 0.176, blue: 0.169, alpha: 1)
            
            shortcut.widthAnchor.constraint(equalToConstant: 35).isActive = true
            shortcut.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            return shortcut
        }()
        
        title = {
            let title = UILabel()
            title.textColor = UIColor(red: 0.165, green: 0.176, blue: 0.169, alpha: 1)
            title.font = .systemFont(ofSize: 16)
            title.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(title)
            title.leadingAnchor.constraint(equalTo: shortcut.trailingAnchor, constant: 10).isActive = true
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

            return title
        }()
    }
    
    func setup(with string: String) {
        title.text = string
    }
}
