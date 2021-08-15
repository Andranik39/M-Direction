//
//  DriverPersonalInfo.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriverPersonalInfo: GradientedVC {
    
    private var firstName: TextField!
    private var lastName: TextField!
    private var gender = 0
    private var birthday: String?
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        title = "Գրանցում"
    }
    
    private func setupSubviews() {
//        let title: UILabel = {
//            let title = UILabel()
//            title.text = "Գրանցում"
//            title.font = .systemFont(ofSize: 32)
//            title.translatesAutoresizingMaskIntoConstraints = false
//
//            content.addSubview(title)
//
//            title.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
//            title.topAnchor.constraint(equalTo: content.topAnchor, constant: 105).isActive = true
//            return title
//        }()
        
        firstName = {
            let firstName = TextField()
            firstName.translatesAutoresizingMaskIntoConstraints = false
            firstName.placeholder = "Անուն"
//            firstName.delegate = firstName
            
            content.addSubview(firstName)
            
            firstName.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            firstName.topAnchor.constraint(equalTo: content.topAnchor, constant: 48).isActive = true
//            firstName.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 48).isActive = true
            firstName.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return firstName
        }()
        
        lastName = {
            let lastName = TextField()
            lastName.translatesAutoresizingMaskIntoConstraints = false
            lastName.placeholder = "Ազգանուն"
//            lastName.delegate = lastName
            
            content.addSubview(lastName)
            
            lastName.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 35).isActive = true
            lastName.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return lastName
        }()
        
        let gender: GenderControl = {
            let gender = GenderControl()
            gender.complition = { rawValue in
                self.gender = rawValue
            }
            gender.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(gender)
            
            gender.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            gender.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 40).isActive = true
            
            return gender
        }()
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fill
            stack.spacing = 10
            stack.translatesAutoresizingMaskIntoConstraints = false

            content.addSubview(stack)

            stack.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            stack.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            stack.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 38).isActive = true

            return stack
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.text = "Ծննդյան օր"
            label.font = .systemFont(ofSize: 20)
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.setContentHuggingPriority(.sceneSizeStayPut, for: .horizontal)
            stack.addArrangedSubview(label)
            
            return label
        }()
        
        let birthdayField: TextField = {
            let date = TextField()
            date.tintColor = .clear
            date.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(date)
            
            let input = DatePicker()
            input.complition = { value in
                date.text = value
                self.birthday = value
            }
            date.inputView = input

            return date
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Առաջ")
            nextButton.translatesAutoresizingMaskIntoConstraints = false

            content.addSubview(nextButton)

            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: birthdayField.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true

            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true

            nextButton.addTarget(self, action: #selector(registerDriverSecondStage), for: [.touchUpInside, .touchDragExit, .touchCancel])
//            nextButton.addTarget(self, action: #selector(imc), for: [.touchUpInside, .touchDragExit, .touchCancel])

            return nextButton
        }()
    }
    
    @objc private func registerDriverSecondStage() {
        view.endEditing(true)
        
        guard let id = UserDefaults.standard.object(forKey: "id") as? Int else { return }
        guard let name = firstName.text, !name.isEmpty else { return }
        guard let surname = lastName.text else { return }
//        guard let gender = gender else { return }
        guard let birthdayTitle = birthday, let birthday = convertDate(birthdayTitle) else { return }
        
        let data = RegisterDriverSecondStage(id: id,
                                             firstName: name,
                                             lastName: surname,
                                             gender: gender,
                                             birthday: birthday)
        print(data)
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        network.post(data: encoded, as: .registerDriverSecondStageRequest) { statusCode in
//            print(statusCode ?? "nothing was recieved")
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigateToTheNextViewController()
                }
            }
        }
    }
    
    @objc private func navigateToTheNextViewController() {
        view.endEditing(true)
            
        let nextVC = DriversLicense()
        
        navigationController?.show(nextVC, sender: nil)
    }
    
    private func convertDate(_ date: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        guard let value = formatter.date(from: date) else { return nil }
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return formatter.string(from: value)
    }
}
