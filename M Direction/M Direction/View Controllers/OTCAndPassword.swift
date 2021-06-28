//
//  UserOTCPassword.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 20.06.2021.
//

import UIKit

final class OTCAndPassword: GradientedVC {
    
    var phone: String?
    var userType: UserType?
    private var otc: TextField!
    private var password: TextField!
    private var repeatPassword: TextField!
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
        
        otc = {
            let otc = TextField()
            otc.translatesAutoresizingMaskIntoConstraints = false
            otc.placeholder = "Հաստատման կոդ"
            otc.delegate = otc
            
            content.addSubview(otc)
            
            otc.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            otc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 38).isActive = true
            otc.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return otc
        }()
        
        password = {
            let password = TextField()
            password.translatesAutoresizingMaskIntoConstraints = false
            password.placeholder = "Գաղտնաբառ"
//        password.isSecureTextEntry = true
            
            content.addSubview(password)
            
            password.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            password.topAnchor.constraint(equalTo: otc.bottomAnchor, constant: 35).isActive = true
            password.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return password
        }()
        
        repeatPassword = {
            let repeatPassword = TextField()
            repeatPassword.translatesAutoresizingMaskIntoConstraints = false
            repeatPassword.placeholder = "Կրկնել գաղտնաբառը"
            repeatPassword.delegate = repeatPassword
//        repeatPassword.isSecureTextEntry = true
            
            content.addSubview(repeatPassword)
            
            repeatPassword.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            repeatPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 35).isActive = true
            repeatPassword.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return repeatPassword
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Առաջ")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(validateActivationCode), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
        
//        let _: UIImageView = {
//            let image = UIImageView(image: UIImage(named: "OTCinput"))
//            image.translatesAutoresizingMaskIntoConstraints = false
//            
//            content.addSubview(image)
//            
//            image.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
////            image.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 38).isActive = true
////            image.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
//            
//            image.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
//            
//            return image
//        }()
    }
    
    @objc private func validateActivationCode() {
        guard let phone = phone else { return }
        guard let recievedCode = otc.text else { return }
        let data = ValidateActivationCode(phone: phone, activationCode: recievedCode)
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        guard let newPassword = password.text, newPassword == repeatPassword.text else {
            print("check password correctness")
            return
        }
        
        guard let userType = userType else { return }
        network.validateActivationCode(userType, data: encoded) { id in
            guard let id = id else { return }
            print(id)
            DispatchQueue.main.async {
                self.navigateToTheNextViewController(type: userType, id: id, password: newPassword)
            }
        }
    }
    
    private func navigateToTheNextViewController(type: UserType, id: Int, password: String) {
        let nextVC: PersonalInfoVC
        
        switch type {
        case .driver:
            nextVC = DriverPersonalInfo()
        case .passenger:
            nextVC = UserFinal()
        }
        
        nextVC.id = id
        nextVC.password = password
        navigationController?.show(nextVC, sender: nil)
    }
    
//    func setPhoneNumber(_ number: String) {
//        phone = number
//    }
}
