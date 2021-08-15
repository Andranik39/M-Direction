//
//  DataSourceDelegate.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 07.08.2021.
//

import UIKit

extension RouteHistory: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: visibleCellID) as! RouteHistoryCell
        cell.setup(with: dataSource[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
}
