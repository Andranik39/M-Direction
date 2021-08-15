//
//  AccountHistoryDelegate.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 10.07.2021.
//

import UIKit

extension PaymantHistory: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            data[indexPath.section].isOpen.toggle()
            let sections = IndexSet(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}
