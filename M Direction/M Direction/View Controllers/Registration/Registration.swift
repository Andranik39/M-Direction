//
//  Registration.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 20.06.2021.
//

import UIKit

final class RegistrationVC: GradientedVC {
    
    private var input: TextField!
    private var userType = 0
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupSubviews() {
        let title: UILabel = {
            let title = UILabel()
            title.text = "Գրանցում"
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
        
        let instruction: UILabel = {
            let instruction = UILabel()
            instruction.numberOfLines = 0
            instruction.text = "Մուտքագրեք Ձեր հեռախոսահամարը"
            instruction.textAlignment = .center
            instruction.translatesAutoresizingMaskIntoConstraints = false
            instruction.font = .systemFont(ofSize: 16)
            
            content.addSubview(instruction)
            
            instruction.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            instruction.topAnchor.constraint(equalTo: userTypes.bottomAnchor, constant: 50).isActive = true
            instruction.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 100).isActive = true
            return instruction
        }()
        
        input = {
            let input = TextField()
            input.translatesAutoresizingMaskIntoConstraints = false
//            input.delegate = input
            input.placeholder = "(+374) 00 000 000"
            
            content.addSubview(input)
            
            input.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            input.topAnchor.constraint(equalTo: instruction.bottomAnchor, constant: 27).isActive = true
            input.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return input
        }()
        
        let nextButton: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Առաջ")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.addTarget(self, action: #selector(sendPhoneNumber), for: [.touchUpInside, .touchDragExit, .touchCancel])
            return nextButton
        }()
        
        let _: UILabel = {
            let termsAndConds = UILabel()
            termsAndConds.numberOfLines = 0
            termsAndConds.text = "Սեղմելով <<Գրանցվել>> կոճակը՝ Դուք ընդունում եք օգտագործման պայմանները"
            termsAndConds.pinTo(content, leading: 29, top: nil, trailing: -140, bottom: -55)
            termsAndConds.font = .systemFont(ofSize: 14)
            
//        termsAndConds.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 175).isActive = true
//        termsAndConds.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 53).isActive = true
//        termsAndConds.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -80).isActive = true
            return termsAndConds
        }()

        let _: UIImageView = {
            let regPart1 = UIImageView()
            regPart1.image = UIImage(named: "Registration Part 2")
            regPart1.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(regPart1)
        
//        regPart1.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 45).isActive = true
//        regPart1.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -36).isActive = true
//        regPart1.widthAnchor.constraint(equalToConstant: 110).isActive = true
//        regPart1.heightAnchor.constraint(equalToConstant: 209).isActive = true
        
            regPart1.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 68).isActive = true
            regPart1.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -17).isActive = true
            regPart1.widthAnchor.constraint(equalToConstant: 136).isActive = true
            regPart1.heightAnchor.constraint(equalToConstant: 269).isActive = true
            
            regPart1.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            return regPart1
        }()
    }
    
    @objc private func sendPhoneNumber() {
        view.endEditing(true)
        
        guard let number = input.text else {
            print("There is no number inputed.")
            return
        }
        let data = SendActivationCode(phone: number)
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        var requestType: NetworkManager.RequestType!
        guard let type = UserType.init(rawValue: userType) else { return }
        
        switch type {
        case .driver:
            requestType = .driverSendActivationCodeRequest
        case .passenger:
            requestType = .passengerSendActivationCodeRequest
        }
        
        network.post(data: encoded, as: requestType) { statusCode in
            print(statusCode ?? "nothing was recieved")
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigateToTheNextViewController(type: type)
                }
            }
        }
    }
    
    private func navigateToTheNextViewController(type: UserType) {
        let nextVC = OTCAndPassword()
        guard let phone = input.text else { return }
        nextVC.phone = phone
        nextVC.userType = type
        navigationController?.show(nextVC, sender: nil)
    }
}
