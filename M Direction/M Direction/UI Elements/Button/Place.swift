//
//  Seat.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.07.2021.
//

import UIKit

final class Place: UIView {
    
    private var imageView: UIImageView!
    private var isEnabled = true
    private var isSelected = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(of type: PlaceType = .person) {
        self.init()
        let image = UIImage(named: type.rawValue)?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
    }

    enum PlaceType: String {
        case person = "Seat"
        case luggage = "Luggage"
    }
    
    private func setup() {
        imageView = {
            let seat = UIImageView()
            seat.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            translatesAutoresizingMaskIntoConstraints = false
            seat.pinTo(self)
            
            return seat
        }()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectSeat))
        addGestureRecognizer(tap)
    }
    
    @objc private func selectSeat() {
        if isEnabled {
            if isSelected {
                imageView.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            } else {
                imageView.tintColor = .systemYellow
            }
            isSelected.toggle()
        }
    }
    
    func busy() {
        imageView.tintColor = UIColor(red: 1, green: 0, blue: 0.075, alpha: 1)
        isEnabled = false
    }
}
