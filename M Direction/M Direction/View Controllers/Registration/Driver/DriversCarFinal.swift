//
//  DriversCarFinal.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriversCar: GradientedVC {
    
    private var brandField: TextField!
    private var modelField: TextField!
    private var colorField: TextField!
    private var carNumberField: TextField!
    
    private var brand: CarParameter?
    private var model: CarParameter?
    private var color: CarParameter?
    private var releaseDate: String?
    
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Գրանցում"
        setupSubviews()
        
        network.get(as: .getMarks) { (marks: [CarParameter]) in
            DispatchQueue.main.async {
                let input = Picker(marks)
                self.brandField.inputView = input
                input.complition = { id, selection in
                    self.brandField.text = selection
                    self.updateModels(for: id)
                    self.modelField.text = nil
                    self.model = nil
                }
            }
        }
        
        let parameter = NetworkManager.RequestParameter(key: "culture", value: "arm")
        network.get(as: .getColors, headers: [parameter]) { (colors: [CarParameter]) in
            DispatchQueue.main.async {
                let input = Picker(colors)
                self.colorField.inputView = input
                input.complition = { id, selection in
                    self.colorField.text = selection
                }
            }
        }
    }
    
    private func setupSubviews() {
        let textFieldStack: UIStackView = {
            let stack = UIStackView()
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.axis = .vertical
            stack.spacing = 35
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(stack)
            
            stack.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            stack.topAnchor.constraint(equalTo: content.topAnchor, constant: 148).isActive = true
            stack.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return stack
        }()
        
        brandField = {
            let coordinator = TextFieldMainDelegate()
            coordinator.setFirstResponder = { textField in
                self.activeTextField = textField
            }
            let brand = TextField()
            brand.newDelegate = coordinator
            brand.translatesAutoresizingMaskIntoConstraints = false
            brand.placeholder = "Մակնիշ"
            brand.tintColor = .clear
            textFieldStack.addArrangedSubview(brand)
            brand.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            return brand
        }()
        
        modelField = {
            let model = TextField()
            model.translatesAutoresizingMaskIntoConstraints = false
            model.placeholder = "Մոդել"
            model.tintColor = .clear
//            surname.delegate = surname
            textFieldStack.addArrangedSubview(model)
            model.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            return model
        }()
        
        colorField = {
            let color = TextField()
            color.translatesAutoresizingMaskIntoConstraints = false
            color.placeholder = "Գույն"
            color.tintColor = .clear
//            surname.delegate = surname
            textFieldStack.addArrangedSubview(color)
            color.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            return color
        }()
        
        let _: TextField = {
            let releaseDate = TextField()
            releaseDate.translatesAutoresizingMaskIntoConstraints = false
            releaseDate.placeholder = "Թողարկման տարեթիվ"
            releaseDate.tintColor = .clear
//            surname.delegate = surname
            textFieldStack.addArrangedSubview(releaseDate)
            releaseDate.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            let input = YearPicker(from: 1991)
            input.complition = { date in
                releaseDate.text = date
                self.releaseDate = date
            }
            releaseDate.inputView = input
            
            return releaseDate
        }()
        
        carNumberField = {
            let coordinator = TextFieldMainDelegate()
            coordinator.setFirstResponder = { textField in
                self.activeTextField = textField
            }
            let carNumber = TextField()
            carNumber.translatesAutoresizingMaskIntoConstraints = false
            carNumber.placeholder = "Պետհամարանիշ"
            carNumber.newDelegate = coordinator
            textFieldStack.addArrangedSubview(carNumber)
            carNumber.widthAnchor.constraint(equalTo: textFieldStack.widthAnchor).isActive = true
            
            return carNumber
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Ավարտել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false

            content.addSubview(nextButton)

            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: carNumberField.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true

            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true

            nextButton.addTarget(self, action: #selector(registerDriverFourthStage), for: [.touchUpInside, .touchDragExit, .touchCancel])

            return nextButton
        }()
    }
    
    @objc private func registerDriverFourthStage() {
        view.endEditing(true)
        
        guard let id = UserDefaults.standard.object(forKey: "id") as? Int else { return }
        guard let brand = brand else { return }
        guard let model = model else { return }
        guard let color = color else { return }
        guard let releaseDate = releaseDate else { return }
        guard let carNumber = carNumberField.text else { return }
        
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
    
    private func updateModels(for mark: Int) {
        network.get(as: .getModelNamesByMark, query: [.init(key: "id", value: "\(mark)")]) { (models: [CarParameter]) in
            DispatchQueue.main.async {
                let input = Picker(models)
                self.modelField.inputView = input
                input.complition = { id, selection in
                    self.modelField.text = selection
                }
            }
        }
    }
}
