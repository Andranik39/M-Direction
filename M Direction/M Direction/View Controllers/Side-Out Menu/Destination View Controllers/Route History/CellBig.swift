//
//  CellBig.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 08.08.2021.
//

import UIKit

final class RouteHistoryCurrentCell: RouteHistoryCell {
    
    static let id = "Current"
    
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var source: UILabel!
    private var destination: UILabel!
    private var busySeatCount: UILabel!
    private var pricePerPerson: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        dateLabel = {
            let label = UILabel()
            label.text = "Սեպտեմբերի 18"
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.font = .systemFont(ofSize: 16)
            label.pinTo(contentView, leading: 25, trailing: nil, bottom: nil)
            
            return label
        }()
        
        let timeSymbol: UIImageView = {
            let symbol = UIImageView()
            symbol.image = UIImage(systemName: "clock")?.withRenderingMode(.alwaysTemplate)
            symbol.tintColor = UIColor(red: 0.486, green: 0.518, blue: 0.557, alpha: 1)
            symbol.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(symbol)
            symbol.widthAnchor.constraint(equalToConstant: 15).isActive = true
            symbol.contentMode = .scaleAspectFit
            symbol.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
            symbol.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 30).isActive = true
            
            return symbol
        }()
        
        timeLabel = {
            let label = UILabel()
            label.text = "14.00"
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.font = .systemFont(ofSize: 16)
            label.pinTo(contentView, leading: nil, top: nil, trailing: nil, bottom: nil)
            label.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: timeSymbol.trailingAnchor, constant: 10).isActive = true

            return label
        }()
        
        let background: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.871, alpha: 1)
            view.layer.shadowColor = UIColor(red: 0.094, green: 0.271, blue: 0.079, alpha: 0.2).cgColor
            view.layer.shadowRadius = 5
            view.layer.shadowOffset = .zero
            view.layer.shadowOpacity = 1
            view.layer.cornerRadius = 12
            view.pinTo(contentView, leading: 25, top: nil, trailing: -25, bottom: -30)
            view.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
            
            return view
        }()
        
        source = {
            let source = UILabel()
            source.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            source.font = .systemFont(ofSize: 16)
            source.pinTo(background, leading: nil, top: 10, trailing: nil, bottom: nil)
            
            return source
        }()
        
        let sourceShortcut: UIImageView = {
            let shortcut = UIImageView()
            shortcut.image = UIImage(named: "Source")
            shortcut.widthAnchor.constraint(equalToConstant: 10).isActive = true
            shortcut.heightAnchor.constraint(equalToConstant: 10).isActive = true
            shortcut.pinTo(background, leading: 15, top: nil, trailing: nil, bottom: nil)
            shortcut.centerYAnchor.constraint(equalTo: source.centerYAnchor).isActive = true
            shortcut.trailingAnchor.constraint(equalTo: source.leadingAnchor, constant: -15).isActive = true

            return shortcut
        }()

        destination = {
            let destination = UILabel()
            destination.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            destination.font = .systemFont(ofSize: 16)
            destination.pinTo(background, leading: nil, top: nil, trailing: -30, bottom: nil)
//            destination.widthAnchor.constraint(equalTo: source.widthAnchor).isActive = true
            destination.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 20).isActive = true
            destination.leadingAnchor.constraint(equalTo: source.leadingAnchor).isActive = true

            return destination
        }()

        let destinationShortcut: UIImageView = {
            let shortcut = UIImageView()
            shortcut.image = UIImage(named: "DestinationSmall")
            shortcut.pinTo(background, leading: nil, top: nil, trailing: nil, bottom: nil)
            shortcut.centerYAnchor.constraint(equalTo: destination.centerYAnchor).isActive = true
            shortcut.centerXAnchor.constraint(equalTo: sourceShortcut.centerXAnchor).isActive = true

            return shortcut
        }()

        let tripStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.translatesAutoresizingMaskIntoConstraints = false
            background.addSubview(stack)
            stack.topAnchor.constraint(equalTo: sourceShortcut.bottomAnchor, constant: 4).isActive = true
            stack.bottomAnchor.constraint(equalTo: destinationShortcut.topAnchor, constant: -4).isActive = true
            stack.centerXAnchor.constraint(equalTo: sourceShortcut.centerXAnchor).isActive = true

            return stack
        }()

        for _ in 0...2 {
            let _: UIView = {
                let shortcut = UIView()
                shortcut.layer.cornerRadius = 4
                shortcut.layer.masksToBounds = true
                shortcut.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
                shortcut.translatesAutoresizingMaskIntoConstraints = false
                shortcut.widthAnchor.constraint(equalToConstant: 5).isActive = true
                shortcut.heightAnchor.constraint(equalToConstant: 5).isActive = true
                tripStack.addArrangedSubview(shortcut)

                return shortcut
            }()
        }
        
        busySeatCount = {
            let busySeatCount = UILabel()
            busySeatCount.textColor = UIColor(red: 0.081, green: 0.604, blue: 0.151, alpha: 1)
            busySeatCount.font = .systemFont(ofSize: 16)
            busySeatCount.pinTo(background, leading: 15, top: nil, trailing: nil, bottom: nil)
            busySeatCount.topAnchor.constraint(equalTo: destination.bottomAnchor, constant: 10).isActive = true

            return busySeatCount
        }()
        
        let _: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            button.pinTo(background, leading: nil, top: nil, trailing: nil, bottom: nil)
            button.leadingAnchor.constraint(equalTo: busySeatCount.trailingAnchor, constant: 10).isActive = true
            button.centerYAnchor.constraint(equalTo: busySeatCount.centerYAnchor).isActive = true

            return button
        }()
        
        let editLabel: UILabel = {
            let label = UILabel()
            label.text = "Խմբագրել"
            label.textColor = UIColor(red: 0.081, green: 0.604, blue: 0.151, alpha: 1)
            label.font = .systemFont(ofSize: 16)
            label.pinTo(background, leading: 15, top: nil, trailing: nil, bottom: nil)
            label.topAnchor.constraint(equalTo: busySeatCount.bottomAnchor, constant: 10).isActive = true

            return label
        }()
        
        let _: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            button.pinTo(background, leading: nil, top: nil, trailing: nil, bottom: nil)
            button.leadingAnchor.constraint(equalTo: editLabel.trailingAnchor, constant: 10).isActive = true
            button.centerYAnchor.constraint(equalTo: editLabel.centerYAnchor).isActive = true

            return button
        }()
        
        let _: HistoryButton = {
            let button = HistoryButton()
            button.title = "Ավարտել"
            button.titleColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            button.color = UIColor(red: 0.638, green: 0.933, blue: 0.845, alpha: 1)
            button.pinTo(background, leading: 15, top: nil, trailing: nil, bottom: nil)
            button.topAnchor.constraint(equalTo: editLabel.bottomAnchor, constant: 20).isActive = true
            button.widthAnchor.constraint(equalToConstant: 125).isActive = true
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.cornerRadius = 15

            return button
        }()
        
        let _: HistoryButton = {
            let button = HistoryButton()
            button.title = "Չեղարկել"
            button.titleColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            button.color = UIColor(red: 0.95, green: 0.253, blue: 0.253, alpha: 1)
            button.pinTo(background, leading: nil, top: nil, trailing: -15, bottom: -20)
            button.topAnchor.constraint(equalTo: editLabel.bottomAnchor, constant: 20).isActive = true
            button.widthAnchor.constraint(equalToConstant: 125).isActive = true
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.cornerRadius = 15

            return button
        }()
        
        let priceContainer: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.871, alpha: 1)
            view.layer.shadowColor = UIColor(red: 0.094, green: 0.271, blue: 0.079, alpha: 0.2).cgColor
            view.layer.shadowRadius = 5
            view.layer.shadowOffset = .zero
            view.layer.shadowOpacity = 1
            view.layer.cornerRadius = 12
            view.pinTo(background, leading: nil, bottom: nil)
            view.leadingAnchor.constraint(equalTo: source.trailingAnchor, constant: 15).isActive = true

            return view
        }()
        
        pricePerPerson = {
            let pricePerPerson = UILabel()
            pricePerPerson.textColor = UIColor(red: 0.95, green: 0.253, blue: 0.253, alpha: 1)
            pricePerPerson.font = .systemFont(ofSize: 14)
            pricePerPerson.pinTo(priceContainer, leading: 10, top: 10, trailing: -10, bottom: -10)

            return pricePerPerson
        }()
    }
    
    override func setup(with model: RouteHistoryCellModel) {
        source.text = model.source
        destination.text = model.destination
        busySeatCount.text = "Զբաղված նստատեղեր - \(model.busySeatCount)"
        pricePerPerson.text = "\(model.pricePerSeat) Դ/անձը"
        
//        let calendar = Calendar.current
//        let monthIndex = calendar.component(.month, from: model.date) - 1
//        let day = calendar.component(.day, from: model.date)
//        dateLabel.text = "\(calendar.monthSymbols[monthIndex]) \(day)"
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH.mm"
//        let time = formatter.string(from: model.date)
//        timeLabel.text = time
    }
}
