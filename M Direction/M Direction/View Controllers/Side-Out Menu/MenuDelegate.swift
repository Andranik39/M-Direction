//
//  MenuDelegate.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 05.07.2021.
//

import UIKit

extension MainMenu: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = menuItems[indexPath.row]
        let nextVC = shouldNavigateTo(item.value)
        nextVC.title = item.title
        
        navigate?(nextVC)
    }
    
    private func shouldNavigateTo(_ value: MenuItem.ItemValues) -> Account {
        switch value {
        case .routeHistory:
            return RouteHistory()
        case .accountHistory:
            return PaymantHistory()
        case .bonuses:
            return Account()
        case .lenguage:
            return Account()
        case .contactUs:
            return Account()
        case .settings:
            return GetRoute()
        }
    }
}
