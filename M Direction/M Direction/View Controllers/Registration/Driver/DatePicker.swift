//
//  DatePicker.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 24.07.2021.
//

import UIKit

final class DatePicker: UIDatePicker {
    
    var complition: ((String) -> Void)?
    private var formatter: DateFormatter!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        primarySetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        primarySetup()
    }
    
    private func primarySetup() {
        formatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            
            return formatter
        }()
        
        datePickerMode = .date
        maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        if #available(iOS 13.4, *) {
            preferredDatePickerStyle = .wheels
        }
        addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
    }
    
    @objc private func dateDidChange() {
        complition?(formatter.string(from: date))
    }
}
