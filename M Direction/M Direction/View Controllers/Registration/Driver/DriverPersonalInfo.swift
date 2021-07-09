//
//  DriverPersonalInfo.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriverPersonalInfo: IdentifiableUserViewController {
    
    private var firstName: TextField!
    private var lastName: TextField!
    private var gender: GenderControl!
//    private var birthday: UIDatePicker!
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
            firstName.delegate = firstName
            
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
            lastName.delegate = lastName
            
            content.addSubview(lastName)
            
            lastName.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 35).isActive = true
            lastName.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return lastName
        }()
        
        gender = {
            let gender = GenderControl()
            gender.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(gender)
            
            gender.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            gender.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 40).isActive = true
            
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
//        let _: AddImage = {
//            let nextButton = AddImage()
//            content.addSubview(nextButton)
//
//            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
//            nextButton.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 38).isActive = true
//            nextButton.addTarget(self, action: #selector(showActionSheet), for: [.touchDown, .touchDragEnter])
//
//            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
//
//            return nextButton
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

            nextButton.addTarget(self, action: #selector(registerDriverFirstStage), for: [.touchUpInside, .touchDragExit, .touchCancel])
//            nextButton.addTarget(self, action: #selector(imc), for: [.touchUpInside, .touchDragExit, .touchCancel])

            return nextButton
        }()
    }
    
//    @objc private func showActionSheet() {
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        let gallery = UIAlertAction(title: "From gallery", style: .default) { _ in
//            print("From gallery")
//        }
//        let camera = UIAlertAction(title: "Take Photo", style: .default) { _ in
//            print("Take a photo")
//        }
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
//
//        actionSheet.addAction(gallery)
//        actionSheet.addAction(camera)
//        actionSheet.addAction(cancel)
//
//        present(actionSheet, animated: true)
//    }
    @objc private func registerDriverFirstStage() {
        view.endEditing(true)
        
        guard let id = id else { return }
        guard let name = firstName.text, !name.isEmpty else { return }
        guard let surname = lastName.text else { return }
        guard let segment = gender.selectedSegment as? GenderSegment else { return }
        guard let gender = segment.state else { return }
        
        let data = RegisterDriverSecondStage(id: id,
                                             firstName: name,
                                             lastName: surname,
                                             gender: gender.rawValue)
        
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
        nextVC.id = id
        
        navigationController?.show(nextVC, sender: nil)
    }
    
//    let imagePickerCoordinator = ImagePickerCoordinator.shared
//    @objc func imc() {
//        let picker = UIImagePickerController()
//        picker.delegate = imagePickerCoordinator
//        present(picker, animated: true)
//    }
}
