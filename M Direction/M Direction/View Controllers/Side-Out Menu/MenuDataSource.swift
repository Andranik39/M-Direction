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
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItem.identifier, for: indexPath) as! MenuItem
        cell.setup(with: menuItems[indexPath.row])
        
        return cell
    }
}
