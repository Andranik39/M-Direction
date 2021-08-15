//
//  AccountHistoryCell.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 10.07.2021.
//

import UIKit

final class PaymantHistoryCell: UITableViewCell {

    static var identifier = "Account History Item"

    private var title: UILabel!

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
//            background.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.4)
////                UIColor(red: 0.902, green: 0.996, blue: 0.869, alpha: 1)
//
//            return background
//        }()
//        backgroundView = background
//
//        let highlighted: UIView = {
//            let highlighted = UIView()
//            highlighted.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.65)
//
//            return highlighted
//        }()
//        selectedBackgroundView = highlighted

        title = {
            let title = UILabel()
            title.textColor = UIColor(red: 0.165, green: 0.176, blue: 0.169, alpha: 1)
            title.font = .systemFont(ofSize: 16)
            title.pinTo(contentView, leading: 15, top: 15, trailing: nil, bottom: -15)

            return title
        }()
    }

    func setup(with item: String) {
        title.text = item
    }
}
