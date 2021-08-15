////
////  ReservedVersion.swift
////  M Direction
////
////  Created by Andranik Khachaturyan on 14.08.2021.
////
//
//import UIKit
//
//final class CalendarPicker: UIViewController {
//
//    var days: [Day]!
////    var startDate: IndexPath?
////    var endDate: IndexPath?
//    var firstDay: IndexPath?
//    var selectionLines = [UIView]()
//
//    private let calendar = Calendar.current
//    private var currentDate = Date()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        days = generateDaysInMonth(baseDate: currentDate)
//        primarySetup()
//    }
//
//    private func primarySetup() {
//        view.backgroundColor = .systemBackground
//
//        let monthLabel: UILabel = {
//            let year = calendar.component(.year, from: currentDate)
//            let monthIndex = calendar.component(.month, from: currentDate)
//            let label = UILabel()
//            label.text = "\(year) " + calendar.monthSymbols[monthIndex - 1]
//            label.pinTo(view, leading: 15, top: nil, bottom: nil)
//            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//
//            return label
//        }()
//
////        let stack: UIStackView = {
////            let stack = UIStackView()
////            stack.axis = .horizontal
////            stack.alignment = .firstBaseline
////            stack.distribution = .fillEqually
////            stack.pinTo(view, top: nil, bottom: nil)
////            stack.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 15).isActive = true
////
////            return stack
////        }()
////
////        for item in calendar.shortWeekdaySymbols {
////            let _: UILabel = {
////                let label = UILabel()
////                label.text = item
////                stack.addArrangedSubview(label)
////
////                return label
////            }()
////        }
//
//        let layout: UICollectionViewFlowLayout = {
//            let layout = CalendarLayout()
//
//            return layout
//        }()
//
//        let _: UICollectionView = {
//            let calendar = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            calendar.backgroundColor = .systemGroupedBackground
//            calendar.backgroundView = UIView()
////            calendar.allowsMultipleSelection = true
//            calendar.isScrollEnabled = false
////            calendar.alwaysBounceVertical = true
//            calendar.dataSource = self
//            calendar.delegate = self
//            calendar.register(DayCell.self, forCellWithReuseIdentifier: DayCell.id)
//            calendar.pinTo(view, top: nil)
//            calendar.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 0).isActive = true
//
//            return calendar
//        }()
//    }
//}
//
//private extension CalendarPicker {
//
//    private struct MonthMetadata {
//        let numberOfDaysInMonth: Int
//        let firstDayOfMonth: Date
//        let firstDayWeekday: Int
//    }
//
//    func generateDaysInMonth(baseDate: Date) -> [Day] {
//        guard let metadata = monthMetadata(for: baseDate) else { fatalError() }
//        let numberOfDaysInMonth = metadata.numberOfDaysInMonth
//        let firstDay = metadata.firstDayOfMonth
////        let offsetInInitalRow = metadata.firstDayWeekday
//        let offsetInInitalRow = 0
//
//        var days = [Day]()
//        for day in 0..<(numberOfDaysInMonth + offsetInInitalRow) {
//            let isWithinDisplayedMonth = day >= offsetInInitalRow
//            let dayOffset = day - offsetInInitalRow
////            let today = calendar.component(.day, from: baseDate)
////            let isWithinDisplayedMonth = day >= offsetInInitalRow && day < today + offsetInInitalRow
//
//            if let newDay = generateDay(offset: dayOffset, for: firstDay, isWithinDisplayedMonth: isWithinDisplayedMonth) {
//                days.append(newDay)
//            }
//        }
//
//        days += generateStartOfNextMonth(using: days[days.count - 1].date)
//
//        return days
//    }
//
//    private func monthMetadata(for date: Date) -> MonthMetadata? {
//        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: date)?.count else { return nil }
//        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return nil }
//        let firstDayWeekday = weekday(of: firstDayOfMonth)
//
//        return .init(numberOfDaysInMonth: numberOfDaysInMonth,
//                     firstDayOfMonth: firstDayOfMonth,
//                     firstDayWeekday: firstDayWeekday)
//    }
//
//    private func generateStartOfNextMonth( using lastDayInMonth: Date) -> [Day] {
//        let additionalDays = 7 - weekday(of: lastDayInMonth)
//        if additionalDays == 0 { return [] }
//
//        var days = [Day]()
//        for offset in 1...additionalDays {
//            if let newDay = generateDay(offset: offset, for: lastDayInMonth, isWithinDisplayedMonth: false) {
//                days.append(newDay)
//            }
//        }
//
//        return days
//    }
//
//    private func generateDay(offset value: Int, for date: Date, isWithinDisplayedMonth: Bool) -> Day? {
//        guard let date = calendar.date(byAdding: .day, value: value, to: date) else { return nil }
//
//        return Day(date: date,
//                   number: String(calendar.component(.day, from: date)),
////                   isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
//                   isWithinDisplayedMonth: isWithinDisplayedMonth)
//    }
//
//    private func weekday(of date: Date) -> Int {
//        var result = calendar.component(.weekday, from: date) - 1
//
//        if result == 0 {
//            result = 7
//        }
//
//        return result
//    }
//}

//final class CalendarLayout: UICollectionViewFlowLayout {
//
//    var insetOfFirstDay: Int? = 3
//
//    override init() {
//        super.init()
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//
//    private func setup() {
//        minimumLineSpacing = 0
//        minimumInteritemSpacing = 0
//
//        let screenWidth = UIScreen.main.bounds.width
//        let itemWidth = screenWidth / 7
//        itemSize = .init(width: itemWidth, height: itemWidth)
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let collectionView = collectionView else { return nil }
//        guard let insetOfFirstDay = insetOfFirstDay else { return nil }
//        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
//
//        var newAttributes: [UICollectionViewLayoutAttributes] = []
//
//        for attribute in attributes {
//            if let cellAttribute = collectionView.collectionViewLayout.layoutAttributesForItem(at: attribute.indexPath) {
//                let itemWidth = itemSize.width
//                let targetOriginX = cellAttribute.frame.origin.x + CGFloat(insetOfFirstDay) * itemWidth
//
//                if targetOriginX <= collectionView.bounds.size.width {
//                    cellAttribute.frame.origin.x = targetOriginX
//                } else {
//                    let shiftedPosition = lround(Double((targetOriginX / itemWidth).truncatingRemainder(dividingBy: 7)))
//
//                    cellAttribute.frame.origin.x = itemWidth * CGFloat(shiftedPosition)
//                    cellAttribute.frame.origin.y += itemWidth
//                }
//
//                newAttributes.append(cellAttribute)
//            }
//        }
//
//        return newAttributes
//    }
//
////    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
////        guard let collectionView = self.collectionView else { return nil }
////        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
////
////        var newAttributes: [UICollectionViewLayoutAttributes] = []
////
////        for attribute in attributes {
////            if let cellAttribute = collectionView.collectionViewLayout.layoutAttributesForItem(at: attribute.indexPath) {
////                let itemSize = cellAttribute.frame.size.width + self.minimumInteritemSpacing
////                let targetOriginX = cellAttribute.frame.origin.x + CGFloat(self.itemInset) * itemSize
////
////                if targetOriginX <= collectionView.bounds.size.width {
////                    cellAttribute.frame.origin.x = targetOriginX
////                } else {
////                    let shiftedPosition = lround(Double((targetOriginX / itemSize).truncatingRemainder(dividingBy: CGFloat(self.numberOfColumns))))
////
////                    cellAttribute.frame.origin.x = itemSize * CGFloat(shiftedPosition)
////                    cellAttribute.frame.origin.y += itemSize
////                }
////
////                newAttributes.append(cellAttribute)
////            }
////        }
////
////        return newAttributes
////    }
//}
