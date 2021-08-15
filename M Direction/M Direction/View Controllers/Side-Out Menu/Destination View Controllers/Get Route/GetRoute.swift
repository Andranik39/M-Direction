//
//  GetRoute.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 12.07.2021.
//

import UIKit

final class GetRoute: Account {
    
    private var source: TextField!
    private var destination: TextField!
    private(set) var hour: UIPickerView!
    private(set) var minute: UIPickerView!
    private var selectedSeats: [UIView]?
    
    override func setupSubviews() {
        title = "Ընտրել երթուղին"
//        let id = UserDefaults.standard.integer(forKey: "id")
//        print(id)
        source = {
            let source = TextField()
            source.placeholder = "Որտեղի՞ց"
//            source.delegate = source
            source.pinTo(content, leading: nil, top: nil, trailing: -40, bottom: nil)
            source.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40).isActive = true
            
            return source
        }()
        
        let sourceShortcut: UIImageView = {
            let shortcut = UIImageView()
            shortcut.image = UIImage(named: "Source")
            shortcut.widthAnchor.constraint(equalToConstant: 20).isActive = true
            shortcut.heightAnchor.constraint(equalToConstant: 20).isActive = true
            shortcut.pinTo(content, leading: 20, top: nil, trailing: nil, bottom: nil)
            shortcut.centerYAnchor.constraint(equalTo: source.centerYAnchor).isActive = true
            shortcut.trailingAnchor.constraint(equalTo: source.leadingAnchor, constant: -20).isActive = true
            
            return shortcut
        }()
        
        destination = {
            let destination = TextField()
            destination.placeholder = "Դեպի ու՞ր"
//            destination.delegate = destination
            destination.pinTo(content, leading: nil, top: nil, trailing: -40, bottom: nil)
            destination.widthAnchor.constraint(equalTo: source.widthAnchor).isActive = true
            destination.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 20).isActive = true
            
            return destination
        }()
        
        let destinationShortcut: UIImageView = {
            let shortcut = UIImageView()
            shortcut.image = UIImage(named: "Destination")
            shortcut.pinTo(content, leading: nil, top: nil, trailing: nil, bottom: nil)
            shortcut.centerYAnchor.constraint(equalTo: destination.centerYAnchor).isActive = true
            shortcut.centerXAnchor.constraint(equalTo: sourceShortcut.centerXAnchor).isActive = true
            
            return shortcut
        }()
        
        let tripStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.translatesAutoresizingMaskIntoConstraints = false
            content.addSubview(stack)
            stack.topAnchor.constraint(equalTo: sourceShortcut.bottomAnchor, constant: 8).isActive = true
            stack.bottomAnchor.constraint(equalTo: destinationShortcut.topAnchor, constant: -8).isActive = true
            stack.centerXAnchor.constraint(equalTo: sourceShortcut.centerXAnchor).isActive = true
            
            return stack
        }()
        
        for _ in 0...2 {
            let _: UIView = {
                let shortcut = UIView()
                shortcut.layer.cornerRadius = 4
                shortcut.layer.masksToBounds = true
                shortcut.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
                shortcut.translatesAutoresizingMaskIntoConstraints = false
                shortcut.widthAnchor.constraint(equalToConstant: 8).isActive = true
                shortcut.heightAnchor.constraint(equalToConstant: 8).isActive = true
                tripStack.addArrangedSubview(shortcut)
                
                return shortcut
            }()
        }
        
        let priceLabel: UILabel = {
            let label = UILabel()
            label.text = "Ուղևորության արժեք-800 Դ/անձը"
            label.textColor = UIColor(red: 0.081, green: 0.604, blue: 0.151, alpha: 1)
            label.font = .systemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            content.addSubview(label)
            label.topAnchor.constraint(equalTo: destination.bottomAnchor, constant: 20).isActive = true
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            return label
        }()
        
        let dayAndTimeLabel: UILabel = {
            let label = UILabel()
            label.text = "Ընտրել օրը և ժամը"
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.font = .systemFont(ofSize: 22)
            label.pinTo(content, leading: 43, top: nil, trailing: nil, bottom: nil)
            label.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
            
            return label
        }()
        
        let mainStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.spacing = 40
            stack.translatesAutoresizingMaskIntoConstraints = false
            content.addSubview(stack)
//            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            stack.topAnchor.constraint(equalTo: dayAndTimeLabel.bottomAnchor, constant: 25).isActive = true
            
            return stack
        }()
        
        let hourStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.addArrangedSubview(stack)
            
            return stack
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.text = "ժամ"
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.font = .systemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            hourStack.addArrangedSubview(label)
            
            return label
        }()
        
        hour = {
            let picker = UIPickerView()
            picker.dataSource = self
            picker.delegate = self
            picker.translatesAutoresizingMaskIntoConstraints = false
            hourStack.addArrangedSubview(picker)
            picker.heightAnchor.constraint(equalToConstant: 120).isActive = true
            picker.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return picker
        }()
        
        let minuteStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.addArrangedSubview(stack)
            
            return stack
        }()
        
        minute = {
            let picker = UIPickerView()
            picker.dataSource = self
            picker.delegate = self
            picker.translatesAutoresizingMaskIntoConstraints = false
            minuteStack.addArrangedSubview(picker)
            picker.heightAnchor.constraint(equalToConstant: 120).isActive = true
            picker.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return picker
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.text = "րոպե"
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.font = .systemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            minuteStack.addArrangedSubview(label)
            
            return label
        }()
        
        let container: UIStackView = {
            let container = UIStackView()
            container.distribution = .fillProportionally
            container.axis = .horizontal
            container.spacing = -25
            container.alignment = .center
            container.pinTo(content, leading: 45, top: nil, trailing: -45, bottom: nil)
            container.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 30).isActive = true
            
            return container
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.text = "Ընտրել մեքենայում\nառկա զբաղված տեղերը"
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 22)
            container.addArrangedSubview(label)
            
            return label
        }()
        
        let _: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            container.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 32).isActive = true
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            button.addTarget(self, action: #selector(selectPlace), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return button
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Հաստատել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(confirm), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
    }
    
    @objc private func selectPlace() {
        guard let rootView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        let car = PlaceSelection()
        car.confirmSelection = { seats in
            self.selectedSeats = seats
        }
        car.pinTo(rootView)
    }
    
    @objc private func confirm() {
        print((selectedSeats ?? []).count)
        guard let rootView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        let alert = ConfirmationAlert()
        alert.pinTo(rootView)
        alert.top = view.layoutMarginsGuide.topAnchor
    }
}
