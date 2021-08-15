//
//  TextFieldDelegate.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 20.06.2021.
//

import UIKit

//extension TextField: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}

class TextFieldMainDelegate: NSObject, UITextFieldDelegate {
    
    var setFirstResponder: ((UITextField?) -> Void)?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setFirstResponder?(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setFirstResponder?(nil)
    }
}
