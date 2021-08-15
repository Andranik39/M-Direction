//
//  AccountHistory.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 10.07.2021.
//

import UIKit

final class PaymantHistory: Account {
    
    var data = [
        Section(title: "Հունվարի 1", rows: [.init(route: "Yerevan - Gyumri", time: "10:00", amount: 3000, isSpent: true)]),
        Section(title: "Հունվարի 2", rows: [
            .init(route: "Gyumri - Dilijan", time: "10:00", amount: 1500, isSpent: true),
            .init(route: "Հաշվի լիցքավորում", time: "12:30", amount: 8000, isSpent: false),
            .init(route: "Dilijan - Yerevan", time: "21:00", amount: 5500, isSpent: true)
        ]),
        Section(title: "Հունվարի 3", rows: [.init(route: "Yerevan - Tsakhkadzor", time: "10:00", amount: 2000, isSpent: true)])
    ]
    
    override func setupSubviews() {
//        let _: UIView = {
//            let container = UIView()
//            container.backgroundColor = .systemPink
//            container.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(container)
//            container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//            container.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
//            container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//            container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//            return container
//        }()
        title = "Հաշվի պատմություն"
        
        let _: UITableView = {
            let tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(AccountHistoryCell.self, forCellReuseIdentifier: AccountHistoryCell.identifier)
            tableView.register(AccountHistoryCellDitailed.self, forCellReuseIdentifier: AccountHistoryCellDitailed.identifier)
            tableView.backgroundColor = .clear
            tableView.alwaysBounceVertical = false
//            tableView.tableFooterView = UIView()
//            tableView.separatorInset = .zero
            tableView.separatorStyle = .none

            tableView.pinTo(view, leading: 25, top: nil, trailing: -25)
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true

            return tableView
        }()
    }
    
    struct Section {
        var isOpen = false
        let title: String
        let rows: [Row]
    }
    
    struct Row {
        let route: String
        let time: String
        let amount: Int
        let isSpent: Bool
    }
}
