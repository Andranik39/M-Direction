//
//  MenuItemModel.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 09.07.2021.
//

import Foundation

struct MenuItem {
    var image: String?
    let title: String
    let value: ItemValues
    
    enum ItemValues {
        case routeHistory, accountHistory, bonuses, lenguage, contactUs, settings
    }
}
