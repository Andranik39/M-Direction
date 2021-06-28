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

struct CompleteRegistration: Encodable {
    let id: Int
    let name: String
    let password: String
}

struct SingInForm: Encodable {
    let phone: String
    let password: String
}

struct ActivationCodeResponce: Decodable {
    let message: String
    var passengerId: Int?
    var driverId: Int?
}

struct DriverInfo {
    
}
