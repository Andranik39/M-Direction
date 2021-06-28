//
//  ViewController.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.06.2021.
//

import UIKit

final class MainVC: GradientedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        let logo: UIImageView = {
            let logo = UIImageView()
            logo.image = UIImage(named: "Logo")
            logo.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(logo)
            
            logo.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            logo.topAnchor.constraint(equalTo: content.topAnchor, constant: 46).isActive = true
            logo.widthAnchor.constraint(equalToConstant: 208).isActive = true
            logo.heightAnchor.constraint(equalToConstant: 152).isActive = true
            
            return logo
        }()
        
        let singIn: Button = {
            let singIn = Button()
            singIn.setup(with: "Մուտք")
            singIn.addTarget(self, action: #selector(logIn), for: [.touchUpInside, .touchDragExit, .touchCancel])
            return singIn
        }()
        
        let singUp: Button = {
            let singUp = Button()
            singUp.setup(with: "Գրանցվել")
            singUp.addTarget(self, action: #selector(startRegistration), for: [.touchUpInside, .touchDragExit, .touchCancel])
            return singUp
        }()
        
        let singButtons: UIStackView = {
            let singButtons = UIStackView()
            singButtons.axis = .horizontal
            singButtons.distribution = .fillEqually
            singButtons.spacing = 15
            singButtons.translatesAutoresizingMaskIntoConstraints = false
            content.addSubview(singButtons)
            singButtons.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            singButtons.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 45).isActive = true
            singButtons.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 30).isActive = true
            singButtons.addArrangedSubview(singIn)
            singButtons.addArrangedSubview(singUp)
            
            return singButtons
        }()
        
        let languages: Languages = {
            let languages = Languages()
            languages.translatesAutoresizingMaskIntoConstraints = false
            content.addSubview(languages)
            languages.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            languages.topAnchor.constraint(equalTo: singButtons.bottomAnchor, constant: 40).isActive = true
            
            return languages
        }()
        
        let image: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "Main")
            image.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(image)
            
            image.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            image.topAnchor.constraint(equalTo: languages.bottomAnchor, constant: 20).isActive = true
            image.widthAnchor.constraint(equalTo: content.widthAnchor).isActive = true
            image.heightAnchor.constraint(equalToConstant: 201).isActive = true
            
            return image
        }()
        
        let _: UIImageView = {
            let questionmark = UIImageView()
            questionmark.image = UIImage(named: "Questionmark")
            questionmark.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(questionmark)
            
            questionmark.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            questionmark.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 45).isActive = true
            questionmark.widthAnchor.constraint(equalToConstant: 45).isActive = true
            questionmark.heightAnchor.constraint(equalToConstant: 45).isActive = true
            
            questionmark.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            return questionmark
        }()
    }
    
    @objc private func startRegistration() {
        let nextVC = RegistrationVC()
        navigationController?.show(nextVC, sender: nil)
    }
    
    @objc private func logIn() {
        let nextVC = SingIn()
        navigationController?.show(nextVC, sender: nil)
    }
}

