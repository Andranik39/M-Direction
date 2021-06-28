//
//  DriverPersonalInfo.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriverPersonalInfo: PersonalInfoVC {
    
    private var name: TextField!
    private var surname: TextField!
    private var gender: GenderControl!
//    private var birthday: UIDatePicker!
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        let title: UILabel = {
            let title = UILabel()
            title.text = "Գրանցում"
            title.font = .systemFont(ofSize: 32)
            title.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(title)
            
            title.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            title.topAnchor.constraint(equalTo: content.topAnchor, constant: 105).isActive = true
            return title
        }()
        
        name = {
            let name = TextField()
            name.translatesAutoresizingMaskIntoConstraints = false
            name.placeholder = "Անուն"
            name.delegate = name
            
            content.addSubview(name)
            
            name.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            name.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 48).isActive = true
            name.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return name
        }()
        
        surname = {
            let surname = TextField()
            surname.translatesAutoresizingMaskIntoConstraints = false
            surname.placeholder = "Ազգանուն"
            surname.delegate = surname
            
            content.addSubview(surname)
            
            surname.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            surname.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 35).isActive = true
            surname.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return surname
        }()
        
        gender = {
            let gender = GenderControl()
            gender.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(gender)
            
            gender.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            gender.topAnchor.constraint(equalTo: surname.bottomAnchor, constant: 40).isActive = true
            
            return gender
        }()
        
//        birthday = {
//            let datePicker = UIDatePicker()
//            datePicker.datePickerMode = .date
//            datePicker.tintColor = .black
//            datePicker.translatesAutoresizingMaskIntoConstraints = false
//
//            content.addSubview(datePicker)
//
//            datePicker.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
//            datePicker.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 38).isActive = true
//
//            return datePicker
//        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Առաջ")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(navigateToTheNextViewController), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
    }
    
    @objc private func navigateToTheNextViewController() {
        let nextVC = DriversLicense()
        navigationController?.show(nextVC, sender: nil)
    }
    
    @objc private func validateActivationCode() {
        guard let segment = gender.selectedSegment as? GenderSegment else { return }
        guard let type = segment.state else { return }
        print(type)
        
//        let data = UIImage(named: "OTCinput")?.pngData()
//        let imageString = data?.base64EncodedString(options: .endLineWithLineFeed)
        
//        guard let phone = phone else { return }
//        guard let recievedCode = otc.text else { return }
//        let data = ValidateActivationCode(phone: phone, activationCode: recievedCode)
//
//        guard let encoded = try? JSONEncoder().encode(data) else {
//            print("Failed to encode")
//            return
//        }
//
//        if password.text == repeatPassword.text {
//
//        }
//
//        guard let userType = userType else { return }
//        network.validateActivationCode(userType, data: encoded) { statusCode in
//            print(statusCode ?? "nothing was recieved")
//        }
    }
    
//    func setPhoneNumber(_ number: String) {
//        phone = number
//    }
}
