//
//  Constants.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 18.06.2021.
//

import UIKit

//[
//    UIColor(red: 0.5, green: 0, blue: 0.25, alpha: 0.22).cgColor,
//    UIColor(red: 0.25, green: 0, blue: 0.5, alpha: 0.22).cgColor,
//    UIColor(red: 0, green: 0, blue: 1, alpha: 0.22).cgColor
//]

let languageModels = [
    LanguageModel(image: UIImage(named: "HY"), shortcut: "HY", value: .armenian),
    LanguageModel(image: UIImage(named: "HY"), shortcut: "EN", value: .english),
    LanguageModel(image: UIImage(named: "HY"), shortcut: "RU", value: .russian)
]

let userCategories = [
    UserCategories(title: "Ուղևոր", value: .passenger),
    UserCategories(title: "Վարորդ", value: .driver)
]

let genderCategories = [
    GenderCategories(title: "Արական", value: .male),
    GenderCategories(title: "Իգական", value: .female)
]

enum UserType: String {
    case passenger = "Passenger"
    case driver = "Driver"
}
