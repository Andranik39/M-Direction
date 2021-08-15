//
//  DriverLicense.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriversLicense: GradientedVC {
    
    private var driverCardFirstSidePhoto: String?
    private var driverCardSecondSidePhoto: String?
    private var driverPassportFirstSidePhoto: String?
    private var driverPassportSecondSidePhoto: String?
    
    private var driverCardSerialNumber: TextField!
    private var driverCardReciveDate: String?
    
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        title = "Գրանցում"
        navigationItem.largeTitleDisplayMode = .never
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
        
        let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            view.layer.cornerRadius = 14
            view.pinTo(content, leading: 15, top: 38, trailing: -15, bottom: nil)
            
            return view
        }()
        
        let firstRow: UILabel = {
           let firstRow = UILabel()
            firstRow.text = "Վարորդական իրավունքի լուսանկար"
            firstRow.font = .systemFont(ofSize: 18)
            firstRow.textAlignment = .center
            firstRow.numberOfLines = 0
            firstRow.pinTo(containerView, leading: 5, top: 30, trailing: -5, bottom: nil)

            return firstRow
        }()
        
        let firstButton: PickPhoto = {
            let picker = PickPhoto()
            picker.setup(with: "1-ին էջ", for: self)
            picker.complition = { result in
                self.driverCardFirstSidePhoto = result
            }
            picker.pinTo(containerView, leading: 40, top: nil, trailing: nil, bottom: nil)
            picker.topAnchor.constraint(equalTo: firstRow.bottomAnchor, constant: 20).isActive = true
            
            return picker
        }()
        
        let _: PickPhoto = {
            let picker = PickPhoto()
            picker.setup(with: "2-րդ էջ", for: self)
            picker.complition = { result in
                self.driverCardSecondSidePhoto = result
            }
            picker.pinTo(containerView, leading: nil, top: nil, trailing: -40, bottom: nil)
            picker.centerYAnchor.constraint(equalTo: firstButton.centerYAnchor).isActive = true
            
            return picker
        }()
        
        let secondRow: UILabel = {
           let secondRow = UILabel()
            secondRow.text = "Մեքենայի տեխնիկական անձնագրի \nլուսանկար"
            secondRow.font = .systemFont(ofSize: 18)
            secondRow.textAlignment = .center
            secondRow.numberOfLines = 0
            secondRow.pinTo(containerView, leading: 5, top: nil, trailing: -5, bottom: nil)
            secondRow.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 50).isActive = true

            return secondRow
        }()
        
        let secondButton: PickPhoto = {
            let picker = PickPhoto()
            picker.setup(with: "1-ին էջ", for: self)
            picker.complition = { result in
                self.driverPassportFirstSidePhoto = result
            }
            picker.pinTo(containerView, leading: 40, top: nil, trailing: nil, bottom: nil)
            picker.topAnchor.constraint(equalTo: secondRow.bottomAnchor, constant: 20).isActive = true
            
            return picker
        }()
        
        let _: PickPhoto = {
            let picker = PickPhoto()
            picker.setup(with: "2-րդ էջ", for: self)
            picker.complition = { result in
                self.driverPassportSecondSidePhoto = result
            }
            picker.pinTo(containerView, leading: nil, top: nil, trailing: -40, bottom: -30)
            picker.centerYAnchor.constraint(equalTo: secondButton.centerYAnchor).isActive = true
            
            return picker
        }()
        
        driverCardSerialNumber = {
            let driverCardSerialNumber = TextField()
            driverCardSerialNumber.translatesAutoresizingMaskIntoConstraints = false
            driverCardSerialNumber.placeholder = "սերիան և համարը"
//            driverCardSerialNumber.delegate = driverCardSerialNumber
            
            content.addSubview(driverCardSerialNumber)
            
            driverCardSerialNumber.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            driverCardSerialNumber.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 35).isActive = true
            driverCardSerialNumber.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return driverCardSerialNumber
        }()
        
        let driverCardReciveDateInput: TextField = {
            let input = TextField()
            input.tintColor = .clear
            input.translatesAutoresizingMaskIntoConstraints = false
            input.placeholder = "տրման ամսաթիվը"
            
            content.addSubview(input)
            
            input.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            input.topAnchor.constraint(equalTo: driverCardSerialNumber.bottomAnchor, constant: 28).isActive = true
            input.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
                        
            let inputView = DatePicker()
            inputView.complition = { value in
                input.text = value
                self.driverCardReciveDate = value
            }
            input.inputView = inputView
            
            return input
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Հաստատել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: driverCardReciveDateInput.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(registerDriverThirdStage), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
    }
    
    @objc private func registerDriverThirdStage() {
        view.endEditing(true)
        
        guard let id = UserDefaults.standard.object(forKey: "id") as? Int else { return }
        
        guard let cardFisrtSide = driverCardFirstSidePhoto else { return }
        guard let cardSecondSide = driverCardSecondSidePhoto else { return }
        guard let passportFisrtSide = driverPassportFirstSidePhoto else { return }
        guard let passportSecondSide = driverPassportSecondSidePhoto else { return }

        guard let serialNumber = driverCardSerialNumber.text else { return }
        guard let reciveDateTitle = driverCardReciveDate, let reciveDate = convertDate(reciveDateTitle) else { return }

        let data = RegisterDriverThirdStage(id: id,
                                            driverCardPhotos: [cardFisrtSide, cardSecondSide],
                                            driverTechPassportPhotos: [passportFisrtSide, passportSecondSide],
                                            driverCardSerialNumber: serialNumber,
                                            driverCardReciveDate: reciveDate)

        guard let encoded = try? JSONEncoder().encode(data) else {
            print("Failed to encode")
            return
        }

        network.post(data: encoded, as: .registerDriverThirdStageRequest) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigateToTheNextViewController()
                }
            }
        }
    }
    
    @objc private func navigateToTheNextViewController() {
        let nextVC = DriversCar()
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
