//
//  SingIn.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class SingIn: GradientedVC {
    
    private var phone: TextField!
    private var password: TextField!
    private var userType = 0
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        let title: UILabel = {
            let title = UILabel()
            title.text = "Մուտք"
            title.font = .systemFont(ofSize: 32)
            title.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(title)
            
            title.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
//            title.topAnchor.constraint(equalTo: content.topAnchor, constant: 22).isActive = true
            title.topAnchor.constraint(equalTo: content.topAnchor, constant: 105).isActive = true
            return title
        }()
        
        let userTypes: UserTypeControl = {
            let userTypes = UserTypeControl()
            userTypes.complition = { rawValue in
                self.userType = rawValue
            }
            userTypes.translatesAutoresizingMaskIntoConstraints = false
            content.addSubview(userTypes)
            userTypes.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            userTypes.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 44).isActive = true
            return userTypes
        }()
        
        phone = {
            let input = TextField()
            input.translatesAutoresizingMaskIntoConstraints = false
//            input.delegate = input
            input.placeholder = "(+374) 00 000 000"
            
            content.addSubview(input)
            
            input.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            input.topAnchor.constraint(equalTo: userTypes.bottomAnchor, constant: 38).isActive = true
            input.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return input
        }()
        
        password = {
            let input = TextField()
            input.translatesAutoresizingMaskIntoConstraints = false
//            input.delegate = input
            input.placeholder = "Գաղտնաբառ"
            
            content.addSubview(input)
            
            input.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            input.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 27).isActive = true
            input.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return input
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Մտնել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(singIn), for: [.touchUpInside, .touchDragExit, .touchCancel])
            return nextButton
        }()
    }
    
    @objc private func singIn() {
        view.endEditing(true)
        
        guard let number = phone.text else {
            print("There is no number inputed.")
            return
        }
        guard let password = password.text else {
            print("There is no number inputed.")
            return
        }
        
        let data = SingInForm(phone: number, password: password)
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        guard let type = UserType.init(rawValue: userType) else { return }
        var requestType: NetworkManager.RequestType!
        
        switch type {
        case .driver:
            requestType = .driverLoginRequest
        case .passenger:
            requestType = .passengerLoginRequest
        }
        
        network.post(data: encoded, as: requestType) { statusCode in
//            print(statusCode ?? "nothing was recieved")
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigateToTheNextViewController()
                }
            }
        }
    }
    
    private func navigateToTheNextViewController() {
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = .red
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
