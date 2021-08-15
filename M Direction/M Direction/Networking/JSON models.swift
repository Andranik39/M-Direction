//
//  JSON models.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 24.06.2021.
//

import Foundation

struct SendActivationCode: Encodable {
    let phone: String
}

struct ValidateActivationCode: Encodable {
    let phone: String
    let activationCode: String
    let password: String
    var name: String? = nil
}

struct ActivationCodeResponce: Decodable {
    let message: String
    var passengerId: Int?
    var driverId: Int?
}

//  Complite registration for user

struct CompleteRegistration: Encodable {
    let id: Int
    let name: String
    let password: String
}

// Registration steps for driver

//struct RegisterDriverFirstStage: Encodable {
//    let phone: String
//    let activationCode: String
//    let password: String
//}

struct RegisterDriverSecondStage: Encodable {
    let id: Int
    let firstName: String
    let lastName: String
    let gender: Int
    var birthday: String
}

struct RegisterDriverThirdStage: Encodable {
    let id: Int
    let driverCardPhotos: [String]
    let driverTechPassportPhotos: [String]
    let driverCardSerialNumber: String
    let driverCardReciveDate: String
}

struct RegisterDriverFourthStage: Encodable {
    let id: Int
    let car: CarInfo
}

struct CarInfo: Encodable {
    let brand: CarParameter
    let model: CarParameter
    let color: CarParameter
    var maxSeatCount: Int = 0
    let releaseDate: String
    let carNumber: String
}

struct CarParameter: Codable, Pickerable {
    var id: Int
    var name: String
}

// Sing in

struct SingInForm: Encodable {
    let phone: String
    let password: String
}

// Get Request responses

//struct CarMark: Decodable, Pickerable {
//    var id: Int?
//    var name: String
//}
