//
//  RouteHistory.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 06.08.2021.
//

import UIKit

final class RouteHistory: Account {
    
    private var userType = 0 {
        didSet {
            if userType == 0 {
                visibleCellID = RouteHistoryCurrentCell.id
            } else {
                visibleCellID = RouteHistoryFinishedCanceledCell.id
            }
            
//            dataSource.removeAll()
////            for n in userType...7 {
////                dataSource.append("\(n)")
////            }
//            dataSource = routeHistory
            list.reloadData()
        }
    }
    
    private(set) var dataSource = routeHistory
    private(set) var visibleCellID = RouteHistoryCurrentCell.id
    private var list: UITableView!
    
    override func setupSubviews() {
        let segmentControl: RouteHistoryControl = {
            let userTypes = RouteHistoryControl()
            userTypes.complition = { rawValue in
                self.userType = rawValue
            }
            userTypes.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(userTypes)
            userTypes.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            userTypes.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
            return userTypes
        }()
        
        list = {
            let tableView = UITableView()
            tableView.dataSource = self
//            tableView.delegate = self
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.register(RouteHistoryFinishedCanceledCell.self, forCellReuseIdentifier: RouteHistoryFinishedCanceledCell.id)
            tableView.register(RouteHistoryCurrentCell.self, forCellReuseIdentifier: RouteHistoryCurrentCell.id)
            tableView.pinTo(view, top: nil)
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 25).isActive = true
            
            return tableView
        }()
    }
}
