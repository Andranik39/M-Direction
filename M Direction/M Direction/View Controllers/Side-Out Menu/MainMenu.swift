//
//  Side-OutMenu.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 04.07.2021.
//

import UIKit

class MainMenu: UIView {
    
    var navigate: ((UIViewController) -> Void)?
    
    private(set) var menuItems = [
        MenuItem(title: "Երթուղու պատմություն", value: .routeHistory),
        MenuItem(title: "Հաշվի պատմություն", value: .accountHistory),
        MenuItem(title: "Միավորներ", value: .bonuses),
        MenuItem(title: "Հայերեն", value: .lenguage),
        MenuItem(title: "Հետադարձ կապ", value: .contactUs),
        MenuItem(title: "Կարգավորումներ", value: .settings)
    ]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        let header: UIView = {
            let header = UIView()
            header.backgroundColor = UIColor(red: 0.867, green: 0.973, blue: 0.851, alpha: 1)
            
            header.pinTo(self, bottom: nil)
            header.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            return header
        }()
        
//        let _: UILabel = {
//            let name = UILabel()
//            name.text = "Աշոտ ID-089677"
//            name.textColor = UIColor(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
//            name.font = .systemFont(ofSize: 20)
//            name.pinTo(header, leading: 15, top: nil, trailing: nil, bottom: -15)
//            
//            return name
//        }()
        
        let _: UITableView = {
            let tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
            tableView.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            tableView.separatorStyle = .none
            
            tableView.pinTo(self, top: nil)
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
            
            return tableView
        }()
    }
}
