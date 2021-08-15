//
//  PickerModel.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 02.07.2021.
//

import UIKit

protocol Pickerable {
    var id: Int { get set }
    var name: String { get set }
}

final class Picker: UIPickerView {
    
    private var rows = [Pickerable]()
    var complition: ((Int, String) -> Void)?
    
    convenience init(_ rows: [Pickerable]) {
        self.init()
        self.rows = rows
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        
    }
}

extension Picker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        rows.count
    }
}

extension Picker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rows[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        complition?(rows[row].id, rows[row].name)
    }
}
