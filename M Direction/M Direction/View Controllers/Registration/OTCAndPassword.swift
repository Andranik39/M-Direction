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
    private var name: TextField?
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
        
        let textFieldStack: UIStackView = {
            let stack = UIStackView()
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.axis = .vertical
            stack.spacing = 35
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(stack)
            
            stack.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            stack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 38).isActive = true
            stack.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return stack
        }()
        
        otc = {
            let otc = TextField()
            otc.translatesAutoresizingMaskIntoConstraints = false
            otc.placeholder = "Հաստատման կոդ"
//            otc.delegate = otc
            textFieldStack.addArrangedSubview(otc)
            otc.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            return otc
        }()
        
        if userType == .passenger {
            name = {
                let name = TextField()
                name.translatesAutoresizingMaskIntoConstraints = false
                name.placeholder = "Անուն"
//                name.delegate = name
                textFieldStack.addArrangedSubview(name)
                name.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
                
                return name
            }()
        }
        
        password = {
            let password = TextField()
            password.translatesAutoresizingMaskIntoConstraints = false
            password.placeholder = "Գաղտնաբառ"
            textFieldStack.addArrangedSubview(password)
            password.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            return password
        }()
        
        repeatPassword = {
            let repeatPassword = TextField()
            repeatPassword.translatesAutoresizingMaskIntoConstraints = false
            repeatPassword.placeholder = "Կրկնել գաղտնաբառը"
//            repeatPassword.delegate = repeatPassword
            textFieldStack.addArrangedSubview(repeatPassword)
            repeatPassword.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
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
        view.endEditing(true)
        
        guard let phone = phone else { return }
        guard let recievedCode = otc.text else { return }
        guard let newPassword = password.text, newPassword == repeatPassword.text else {
            print("check password correctness")
            return
        }
        
        var data = ValidateActivationCode(phone: phone, activationCode: recievedCode, password: newPassword)
        
        if let usersName = name?.text {
            data.name = usersName
        }
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        guard let userType = userType else { return }
        network.validateActivationCode(userType, data: encoded) { id in
            DispatchQueue.main.async {
                self.navigateToTheNextViewController(type: userType, id: id)
            }
        }
    }
    
    private func navigateToTheNextViewController(type: UserType, id: Int?) {
        let nextVC: UIViewController
        
        switch type {
        case .driver:
            nextVC = DriverPersonalInfo()
            guard let id = id else { return }
            UserDefaults.standard.removeObject(forKey: "id")
            UserDefaults.standard.setValue(id, forKey: "id")
        case .passenger:
            nextVC = GetRoute()
            navigationController?.isNavigationBarHidden = true
        }
        
        navigationController?.show(nextVC, sender: nil)
    }
    
//    func setPhoneNumber(_ number: String) {
//        phone = number
//    }
}
