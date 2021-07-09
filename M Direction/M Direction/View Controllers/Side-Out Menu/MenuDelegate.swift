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
//        let nextVC = UIViewController()
//        nextVC.title = menuItems[indexPath.row]
//        nextVC.view.backgroundColor = .systemYellow
//        navigationController?.show(nextVC, sender: nil)
        let nextVC = Account()
        nextVC.title = menuItems[indexPath.row]
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "dollarsign.circle"), for: .normal)
//        button.addTarget(MainMenu.self, action: #selector(a), for: [.touchUpInside, .touchDragExit, .touchCancel])
//        nextVC.trailingButton = button
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    
//    @objc func a() {
//        print(1)
//    }
}
