//
//  AccountHistoryCellDitailed.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 11.07.2021.
//

import UIKit

final class PaymantHistoryCellDitailed: UITableViewCell {

    static var identifier = "Account History Diatiled Item"

    private var route: UILabel!
    private var time: UILabel!
    private var amount: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
//        let background: UIView = {
//            let background = UIView()
//            background.backgroundColor = UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
//
//            return background
//        }()
//        backgroundView = background
//
//        let highlighted: UIView = {
//            let highlighted = UIView()
//            highlighted.backgroundColor = .clear
//
//            return highlighted
//        }()
//        selectedBackgroundView = highlighted

        route = {
            let title = UILabel()
//            title.textColor = UIColor(red: 0.165, green: 0.176, blue: 0.169, alpha: 1)
            title.font = .systemFont(ofSize: 16)
            title.pinTo(contentView, leading: 15, top: 10, trailing: nil, bottom: nil)

            return title
        }()
        
        time = {
            let time = UILabel()
//            title.textColor = UIColor(red: 0.165, green: 0.176, blue: 0.169, alpha: 1)
            time.font = .systemFont(ofSize: 12)
            time.pinTo(contentView, leading: 15, top: nil, trailing: nil, bottom: -10)
            time.topAnchor.constraint(equalTo: route.bottomAnchor, constant: 5).isActive = true

            return time
        }()
        
        amount = {
            let amount = UILabel()
//            title.textColor = UIColor(red: 0.165, green: 0.176, blue: 0.169, alpha: 1)
            amount.font = .systemFont(ofSize: 16)
            amount.pinTo(contentView, leading: nil, top: nil, trailing: -15, bottom: nil)
            amount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

            return amount
        }()
    }

    func setup(with item: PaymantHistory.Row) {
        route.text = item.route
        time.text = item.time
        if item.isSpent {
            amount.text = "-\(item.amount)"
            amount.textColor = .systemRed
        } else {
            amount.text = "+\(item.amount)"
            amount.textColor = .systemGreen
        }
    }
}
