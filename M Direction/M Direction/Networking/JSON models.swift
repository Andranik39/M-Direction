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

struct RegisterDriverFirstStage: Encodable {
    let id: Int
    let password: String
}

struct RegisterDriverSecondStage: Encodable {
    let id: Int
    let firstName: String
    let lastName: String
    let gender: Int
    var birthday: String = ""
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
    let brand: String
    let model: String
    let color: String
    var maxSeatCount: Int = 0
    let releaseDate: String
    let carNumber: String
}

// Sing in

struct SingInForm: Encodable {
    let phone: String
    let password: String
}
