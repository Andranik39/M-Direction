//
//  MenuItem.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 05.07.2021.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
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

    private func setupSubviews() {
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
    
    func setup(with item: MenuItem) {
        title.text = item.title
    }
}
