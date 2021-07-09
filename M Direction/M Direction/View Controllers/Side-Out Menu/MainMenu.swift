//
//  Side-OutMenu.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 04.07.2021.
//

import UIKit

class MainMenu: UIViewController {
    
    private(set) var menuItems = ["Երթուղու պատմություն", "Հաշվի պատմություն", "Միավորներ", "Հայերեն", "Հետադարձ կապ", "Կարգավորումներ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        setupSubviews()
    }
    
    private func setupSubviews() {
        let header: UIView = {
            let header = UIView()
            header.backgroundColor = UIColor(red: 0.867, green: 0.973, blue: 0.851, alpha: 1)
            
            header.pinTo(view, bottom: nil)
            header.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            return header
        }()
        
        let _: UITableView = {
            let tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(MenuItem.self, forCellReuseIdentifier: MenuItem.identifier)
            tableView.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            tableView.separatorStyle = .none
            
            tableView.pinTo(view, top: nil)
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
            
            return tableView
        }()
    }
}
