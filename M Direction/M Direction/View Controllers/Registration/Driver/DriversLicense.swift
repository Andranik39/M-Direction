//
//  DriverLicense.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriversLicense: IdentifiableUserViewController {
    
    private var driverCardFisrtSidePhoto: String?
    private var driverCardSecondSidePhoto: String?
    private var driverPassportFisrtSidePhoto: String?
    private var driverPassportSecondSidePhoto: String?
    
    private var driverCardSerialNumber: TextField!
    private var driverCardReciveDate: TextField!
    
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
        
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            view.layer.cornerRadius = 14
            view.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(view)
            
            view.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            view.topAnchor.constraint(equalTo: content.topAnchor, constant: 38).isActive = true
//            view.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 38).isActive = true
            view.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16).isActive = true
            view.heightAnchor.constraint(equalToConstant: 270).isActive = true
            
            return view
        }()
        
//        let firstRow: UILabel = {
//           let firstRow = UILabel()
//            firstRow.text = "Վարորդական իրավունքի լուսանկար"
////            firstRow.font = .systemFont(ofSize: 18)
//            firstRow.numberOfLines = 0
//            firstRow.translatesAutoresizingMaskIntoConstraints = false
//
//            view.addSubview(firstRow)
//
//            firstRow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            firstRow.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
//            firstRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
//
//            return firstRow
//        }()
        
        driverCardSerialNumber = {
            let driverCardSerialNumber = TextField()
            driverCardSerialNumber.translatesAutoresizingMaskIntoConstraints = false
            driverCardSerialNumber.placeholder = "սերիան և համարը"
            driverCardSerialNumber.delegate = driverCardSerialNumber
            
            content.addSubview(driverCardSerialNumber)
            
            driverCardSerialNumber.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            driverCardSerialNumber.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 35).isActive = true
            driverCardSerialNumber.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return driverCardSerialNumber
        }()
        
        driverCardReciveDate = {
            let driverCardReciveDate = TextField()
            driverCardReciveDate.translatesAutoresizingMaskIntoConstraints = false
            driverCardReciveDate.placeholder = "տրման ամսաթիվը"
            driverCardReciveDate.delegate = driverCardReciveDate
            
            content.addSubview(driverCardReciveDate)
            
            driverCardReciveDate.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            driverCardReciveDate.topAnchor.constraint(equalTo: driverCardSerialNumber.bottomAnchor, constant: 28).isActive = true
            driverCardReciveDate.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return driverCardReciveDate
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Հաստատել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: driverCardReciveDate.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(registerDriverFirstStage), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
    }
    
    @objc private func registerDriverFirstStage() {
        view.endEditing(true)
        
        guard let id = id else { return }
        guard let cardFisrtSide = driverCardFisrtSidePhoto else { return }
        guard let cardSecondSide = driverCardSecondSidePhoto else { return }
        guard let passportFisrtSide = driverPassportFisrtSidePhoto else { return }
        guard let passportSecondSide = driverPassportSecondSidePhoto else { return }
        
        guard let serialNumber = driverCardSerialNumber.text else { return }
        guard let reciveDate = driverCardReciveDate.text else { return }
        
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
        nextVC.id = id
        
        navigationController?.show(nextVC, sender: nil)
    }
}
