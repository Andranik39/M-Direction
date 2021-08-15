//
//  AccountHistoryDataSource.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 10.07.2021.
//

import UIKit

extension PaymantHistory: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data[section].isOpen {
            return data[section].rows.count + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymantHistoryCell.identifier, for: indexPath) as! PaymantHistoryCell
            cell.setup(with: data[indexPath.section].title)
            cell.backgroundColor = .clear
            let view = UIView()
            
            let red: CGFloat = 186 / 255
            let green: CGFloat = 218 / 255
            let blue: CGFloat = 195 / 255
            view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
            cell.backgroundView = view
            cell.selectedBackgroundView = UIView()
            
            if indexPath.section == 0 {
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else if indexPath.section == data.count - 1 && !data[indexPath.section].isOpen {
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymantHistoryCellDitailed.identifier, for: indexPath) as! PaymantHistoryCellDitailed
            cell.setup(with: data[indexPath.section].rows[indexPath.row - 1])
            cell.backgroundColor = .clear
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            cell.backgroundView = view
            cell.selectedBackgroundView = UIView()
            
            if indexPath.section == data.count - 1 && indexPath.row == data[indexPath.section].rows.count {
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            
            return cell
        }
    }
}
