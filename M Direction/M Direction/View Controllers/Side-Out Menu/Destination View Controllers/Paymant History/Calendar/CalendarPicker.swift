//
//  CalendarPicker.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 24.07.2021.
//

import UIKit

final class CalendarPicker: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        primarySetup()
    }
    
    private func primarySetup() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0

            return layout
        }()

        let _: UICollectionView = {
            let calendar = UICollectionView(frame: .zero, collectionViewLayout: layout)
            calendar.backgroundColor = .systemGroupedBackground
            calendar.isScrollEnabled = false
            calendar.dataSource = self
            calendar.delegate = self
            calendar.register(DayCell.self, forCellWithReuseIdentifier: DayCell.id)
            calendar.pinTo(view)

            return calendar
        }()
    }
}

extension CalendarPicker: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.id, for: indexPath) as! DayCell
        cell.setup(indexPath.item)
        return cell
    }
}

extension CalendarPicker: UICollectionViewDelegate {

}

final class DayCell: UICollectionViewCell {

    static let id = "Day"

    private var title: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        title = {
            let label = UILabel()
            label.pinTo(contentView)

            return label
        }()
    }

    func setup(_ day: Int) {
        title.text = "\(day)"
    }
}
