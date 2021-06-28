//
//  TextFieldDelegate.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 20.06.2021.
//

import UIKit

extension TextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
