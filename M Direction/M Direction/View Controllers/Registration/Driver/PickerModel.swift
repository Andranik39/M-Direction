//
//  PickerModel.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 02.07.2021.
//

import UIKit

final class PickerModel: UIPickerView {
    private var rows = [String]()
    
    convenience init(_ rows: [String]) {
        self.init()
        self.rows = rows
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        
    }
}

extension PickerModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        rows.count
    }
}

extension PickerModel: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rows[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }
}
