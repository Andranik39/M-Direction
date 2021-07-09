//
//  UserFinal.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class UserFinal: IdentifiableUserViewController {
    
    var password: String?
    private var name: TextField!
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
            name.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 38).isActive = true
            name.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return name
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Ավարտել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(completeRegistration), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
    }
    
    @objc private func completeRegistration() {
        view.endEditing(true)
        
        guard let id = id else { return }
        guard let password = password else { return }
        guard let userName = name.text else { return }
        let data = CompleteRegistration(id: id, name: userName, password: password)
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        network.post(data: encoded, as: .passengerComleteRegistrationRequest) { statusCode in
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
        nextVC.view.backgroundColor = .blue
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
