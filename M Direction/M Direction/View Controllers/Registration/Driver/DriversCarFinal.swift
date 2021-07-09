//
//  DriversCarFinal.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriversCar: IdentifiableUserViewController {
    
    private var brand: TextField!
    private var model: TextField!
    private var color: TextField!
    private var releaseDate: TextField!
    private var carNumber: TextField!
    
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        title = "Գրանցում"
//        navigationItem.largeTitleDisplayMode = .never
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
        
        brand = {
            let brand = TextField()
            brand.translatesAutoresizingMaskIntoConstraints = false
            brand.placeholder = "Մակնիշ"
            
            let input = PickerModel(["A", "B", "C"])
            brand.inputView = input
            brand.tintColor = .clear
//            brand.delegate = brand
            
            content.addSubview(brand)
            
            brand.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            brand.topAnchor.constraint(equalTo: content.topAnchor, constant: 48).isActive = true
//            brand.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 48).isActive = true
            brand.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return brand
        }()
        
        model = {
            let model = TextField()
            model.translatesAutoresizingMaskIntoConstraints = false
            model.placeholder = "Մոդել"
//            surname.delegate = surname
            
            content.addSubview(model)
            
            model.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            model.topAnchor.constraint(equalTo: brand.bottomAnchor, constant: 35).isActive = true
            model.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return model
        }()
        
        color = {
            let color = TextField()
            color.translatesAutoresizingMaskIntoConstraints = false
            color.placeholder = "Գույն"
//            surname.delegate = surname
            
            content.addSubview(color)
            
            color.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            color.topAnchor.constraint(equalTo: model.bottomAnchor, constant: 35).isActive = true
            color.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return color
        }()
        
        releaseDate = {
            let releaseDate = TextField()
            releaseDate.translatesAutoresizingMaskIntoConstraints = false
            releaseDate.placeholder = "Թողարկման տարեթիվ"
//            surname.delegate = surname
            
            content.addSubview(releaseDate)
            
            releaseDate.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            releaseDate.topAnchor.constraint(equalTo: color.bottomAnchor, constant: 35).isActive = true
            releaseDate.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return releaseDate
        }()
        
        carNumber = {
            let carNumber = TextField()
            carNumber.translatesAutoresizingMaskIntoConstraints = false
            carNumber.placeholder = "Պետհամարանիշ"
//            surname.delegate = surname
            
            content.addSubview(carNumber)
            
            carNumber.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            carNumber.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 35).isActive = true
            carNumber.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return carNumber
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Ավարտել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false

            content.addSubview(nextButton)

            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: carNumber.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true

            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true

            nextButton.addTarget(self, action: #selector(registerDriverSecondStage), for: [.touchUpInside, .touchDragExit, .touchCancel])

            return nextButton
        }()
    }
    
    @objc private func registerDriverSecondStage() {
        view.endEditing(true)
        
        guard let id = id else { return }
        
        guard let brand = brand.text else { return }
        guard let model = model.text else { return }
        guard let color = color.text else { return }
        guard let releaseDate = releaseDate.text else { return }
        guard let carNumber = carNumber.text else { return }
        
        let car = CarInfo(brand: brand,
                          model: model,
                          color: color,
                          releaseDate: releaseDate,
                          carNumber: carNumber)
        let data = RegisterDriverFourthStage(id: id, car: car)
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }
        
        network.post(data: encoded, as: .registerDriverFourthStageRequest) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigateToTheNextViewController()
                }
            }
        }
    }
    
    @objc private func navigateToTheNextViewController() {
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = .systemTeal
//        navigationController?.isNavigationBarHidden = true
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
