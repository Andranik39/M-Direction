//
//  PickerViewSetup.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 13.07.2021.
//

import UIKit

extension GetRoute: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hour {
            return 24
        } else {
            return 6
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var multiplier = 1
        
        if pickerView == minute {
            multiplier *= 10
        }
        
        var title = "\(row * multiplier)"
        
        if title.count == 1 {
            title.insert("0", at: title.startIndex)
        }
        
        let result = UILabel()
        result.text = title
        result.textAlignment = .center
        result.font = .systemFont(ofSize: 24)
        
        return result
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        40
    }
}
