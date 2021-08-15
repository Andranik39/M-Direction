//
//  CalendarCell.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 26.07.2021.
//

import UIKit

final class DayCell: UICollectionViewCell {

    static let id = "Day"
    
    private(set) lazy var size: CGFloat = {
        traitCollection.horizontalSizeClass == .compact ? min(min(frame.width, frame.height) - 10, 60): 45
    }()

    var day: Day? {
        didSet {
            guard let day = day else { return }
            title.text = day.number
            title.textColor = day.isWithinDisplayedMonth ? nil: .secondaryLabel
        }
    }
    private var title: UILabel!
    private var background: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        background = {
            let view = UIView()
            view.clipsToBounds = true
            view.layer.cornerRadius = size / 2
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: size).isActive = true
            view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            return view
        }()
        
        title = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(label)
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

            return label
        }()
    }
    
    func selectDay() {
        background.backgroundColor = .systemYellow
    }
    
    func deselectDay() {
        background.backgroundColor = .clear
    }
}
