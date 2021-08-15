//
//  MenuDataSource.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 05.07.2021.
//

import UIKit

extension MainMenu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.identifier, for: indexPath) as! MenuItemCell
        cell.setup(with: menuItems[indexPath.row])
        cell.backgroundColor = .clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.65)
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
}
