//
//  DriverLicense.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 27.06.2021.
//

import UIKit

final class DriversLicense: GradientedVC {
    
    private var serialNumber: TextField!
    private var date: TextField!

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
        
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
            view.layer.cornerRadius = 14
            view.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(view)
            
            view.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            view.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 38).isActive = true
            view.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16).isActive = true
            view.heightAnchor.constraint(equalToConstant: 270).isActive = true
            
            return view
        }()
        
        let firstRow: UILabel = {
           let firstRow = UILabel()
            firstRow.text = "Վարորդական իրավունքի լուսանկար"
//            firstRow.font = .systemFont(ofSize: 18)
            firstRow.numberOfLines = 0
            firstRow.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(firstRow)
            
            firstRow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            firstRow.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
            firstRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            
            return firstRow
        }()
        
        serialNumber = {
            let serialNumber = TextField()
            serialNumber.translatesAutoresizingMaskIntoConstraints = false
            serialNumber.placeholder = "սերիան և համարը"
            serialNumber.delegate = serialNumber
            
            content.addSubview(serialNumber)
            
            serialNumber.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            serialNumber.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 35).isActive = true
            serialNumber.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return serialNumber
        }()
        
        date = {
            let date = TextField()
            date.translatesAutoresizingMaskIntoConstraints = false
            date.placeholder = "տրման ամսաթիվը"
            date.delegate = date
            
            content.addSubview(date)
            
            date.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            date.topAnchor.constraint(equalTo: serialNumber.bottomAnchor, constant: 28).isActive = true
            date.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            return date
        }()
        
        let _: Button = {
            let nextButton = Button()
            nextButton.setup(with: "Հաստատել")
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            content.addSubview(nextButton)
            
            nextButton.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
            nextButton.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 38).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 50).isActive = true
            
            nextButton.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(navigateToTheNextViewController), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return nextButton
        }()
    }
    
    @objc private func navigateToTheNextViewController() {
        let nextVC = PersonalInfoVC()
        navigationController?.show(nextVC, sender: nil)
    }
}
