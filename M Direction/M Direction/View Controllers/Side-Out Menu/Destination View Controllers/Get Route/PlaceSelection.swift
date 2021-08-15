//
//  SeatSelection.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 15.07.2021.
//

import UIKit

final class PlaceSelection: GradientedVC {
    
    private var selectedSeats = [UIView]()
    private let isMiddleRowHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _: UIView = {
            let cover = UIView()
            cover.backgroundColor = .black
            cover.alpha = 0.4
            cover.pinTo(view)

            return cover
        }()
        
        let _: UIButton = {
            let button = UIButton(type: .system)
            button.pinTo(view, leading: nil, top: 40, trailing: -30, bottom: nil)
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
//                UIColor(red: 0.296, green: 0.617, blue: 0.34, alpha: 1)
            
//            nextButton.addTarget(self, action: #selector(validateActivationCode), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return button
        }()
        
        let title: UILabel = {
            let label = UILabel()
            label.text = "Ընտրել բոլոր զբաղված նստատեղերը"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 22)
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.numberOfLines = 0
            label.pinTo(view, leading: 55, top: 75, trailing: -55, bottom: nil)
            
            return label
        }()
        
        let car: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Car")
            imageView.isUserInteractionEnabled = true
//            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            return imageView
        }()
        
//        setting up seats

        let rows: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .trailing
            stack.distribution = .equalSpacing
            stack.pinTo(car, leading: 40, top: 142, trailing: -40, bottom: -163)

            return stack
        }()
        
        let _: Place = {
            let seat = Place(of: .person)
            seat.busy()
            rows.addArrangedSubview(seat)
            
            return seat
        }()
        
        for row in 0...1 {

            if isMiddleRowHidden && row == 0 {
                continue
            }

            let seatsRow: UIStackView = {
                let stack = UIStackView()
                stack.axis = .horizontal
                stack.alignment = .center
                stack.distribution = .equalSpacing
                stack.translatesAutoresizingMaskIntoConstraints = false
                rows.addArrangedSubview(stack)
                stack.leadingAnchor.constraint(equalTo: rows.leadingAnchor).isActive = true
                stack.centerXAnchor.constraint(equalTo: rows.centerXAnchor).isActive = true

                return stack
            }()

            for _ in 0...2 {
                let _: Place = {
                    let seat = Place(of: .person)
                    seatsRow.addArrangedSubview(seat)
                    
                    return seat
                }()
            }
        }
        
//        setting up baggage
        
        let luggagesRow: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.pinTo(car, leading: 62, top: 358, trailing: -62, bottom: -60)

            return stack
        }()

        for _ in 0...1 {
            let _: Place = {
                let luggage = Place(of: .luggage)
                luggagesRow.addArrangedSubview(luggage)
                
                return luggage
            }()
        }
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Հաստատել")
            nextButton.pinTo(view, leading: 50, top: nil, trailing: -50, bottom: nil)
            nextButton.topAnchor.constraint(equalTo: car.bottomAnchor, constant: 40).isActive = true
            
            return nextButton
        }()
    }
}
