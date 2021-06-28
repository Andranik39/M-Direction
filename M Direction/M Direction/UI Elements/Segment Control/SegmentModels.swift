//
//  LanguageModel.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 18.06.2021.
//

import UIKit

struct LanguageModel {
    var image: UIImage?
    let shortcut: String
    let value: AvailableLanguages
    
    enum AvailableLanguages {
        case armenian, english, russian
    }
}

struct UserCategories {
    let title: String
    let value: UserType
}

struct GenderCategories {
    let title: String
    let value: Gender
    
    enum Gender {
        case male, female
    }
}
