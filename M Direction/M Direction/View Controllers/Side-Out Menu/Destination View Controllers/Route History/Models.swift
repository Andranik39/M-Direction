//
//  Models.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 08.08.2021.
//

import Foundation

struct RouteHistoryCellModel {
    let source: String
    let destination: String
    let pricePerSeat: Int
    let busySeatCount: Int
    var date = Date()
}

let routeHistory = [
    RouteHistoryCellModel(source: "Երևան, Չարենցի փ․", destination: "Արարատի մարզ, գ․ Գեղանիստ", pricePerSeat: 500, busySeatCount: 4),
    RouteHistoryCellModel(source: "Արարատի մարզ, գ․ Գեղանիստ", destination: "Երևան, Չարենցի փ․", pricePerSeat: 1500, busySeatCount: 7),
    RouteHistoryCellModel(source: "Երևան, Չարենցի փ․", destination: "Արարատի մարզ, գ․ Գեղանիստ", pricePerSeat: 1000, busySeatCount: 5)
]
