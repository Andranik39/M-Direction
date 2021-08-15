//
//  YearPicker.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 24.07.2021.
//

import UIKit

final class YearPicker: UIPickerView {
    
    var complition: ((String) -> Void)?
    
    private var startYear = 1990
    private let endYear = Calendar.current.component(.year, from: Date())
    
    convenience init(from year: Int) {
        self.init()
        self.startYear = year
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        
    }
}

extension YearPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        endYear - startYear
    }
}

extension YearPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(startYear + row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        complition?(String(startYear + row))
    }
}
