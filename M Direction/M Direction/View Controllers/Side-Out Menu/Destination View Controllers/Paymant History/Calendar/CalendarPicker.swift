//
//  CalendarPicker.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 24.07.2021.
//

import UIKit

final class CalendarPicker: UIViewController {
    
    var days: [Day]!
    var selectedDays = [SelectedDay]()
    
    private var currentDate = Date()
    private let calendar = Calendar.current
    private(set) var calendarPage: CalendarPage!
    private(set) var pageNumber = 0 {
        didSet {
            guard let date = calendar.date(byAdding: .month, value: pageNumber, to: currentDate) else { return }
            days = generateDaysInMonth(baseDate: date)
            calendarPage.deselectRange()
            calendarPage.reloadData()
            selectDaysIfNeeded()
        }
    }
    
    private func selectDaysIfNeeded() {
        if pageNumber == -1 {
            calendarPage.selectDay(at: .init(item: 13, section: 0))
        }
    }
    
    struct SelectedDay {
        let indexPath: IndexPath
        let page: Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var dc = DateComponents()
//        dc.day = 30
//        dc.month = 3
//        dc.year = 2021
//        currentDate = calendar.date(from: dc) ?? Date()
        days = generateDaysInMonth(baseDate: currentDate)
        primarySetup()
    }
    
    private func primarySetup() {
        view.backgroundColor = .systemBackground
        
        let monthLabel: UILabel = {
//            let year = calendar.component(.year, from: currentDate)
//            let monthIndex = calendar.component(.month, from: currentDate)
//            let label = UILabel()
//            label.text = "\(year) " + calendar.monthSymbols[monthIndex - 1]
            let label = UILabel()
            label.text = "2021 թ․ Հուլիս"
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
            label.pinTo(view, leading: 15, top: nil, bottom: nil)
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
            
            return label
        }()
        
        let _: Stepper = {
            let stepper = Stepper()
            stepper.value = pageNumber
            stepper.valueChanged = { newValue in
                self.pageNumber = newValue
            }
            stepper.pinTo(view, leading: nil, top: nil, trailing: -15, bottom: nil)
            stepper.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor).isActive = true
            
            return stepper
        }()
        
        let weekdays: Weekdays = {
            let weekdays = Weekdays()
            weekdays.pinTo(view, top: nil, bottom: nil)
            weekdays.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 25).isActive = true
            
            return weekdays
        }()
        
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 7
            layout.itemSize = .init(width: itemWidth, height: itemWidth)

            return layout
        }()

        calendarPage = {
            let calendar = CalendarPage(frame: .zero, collectionViewLayout: layout)
            calendar.dataSource = self
            calendar.delegate = self
            calendar.register(DayCell.self, forCellWithReuseIdentifier: DayCell.id)
            calendar.pinTo(view, top: nil)
            calendar.topAnchor.constraint(equalTo: weekdays.bottomAnchor, constant: 10).isActive = true

            return calendar
        }()
    }
}

private extension CalendarPicker {
    
    private struct MonthMetadata {
        let numberOfDaysInMonth: Int
        let firstDayOfMonth: Date
        let firstDayWeekday: Int
    }
    
    func generateDaysInMonth(baseDate: Date) -> [Day] {
        guard let metadata = monthMetadata(for: baseDate) else { fatalError() }
        let numberOfDaysInMonth = metadata.numberOfDaysInMonth
        let firstDay = metadata.firstDayOfMonth
        let offsetInInitalRow = metadata.firstDayWeekday
        
        var days = [Day]()
        for day in 1..<(numberOfDaysInMonth + offsetInInitalRow) {
            let isWithinDisplayedMonth = day >= offsetInInitalRow
            let dayOffset = day - offsetInInitalRow
//            let today = calendar.component(.day, from: baseDate)
//            let isWithinDisplayedMonth = day >= offsetInInitalRow && day < today + offsetInInitalRow
            
            if let newDay = generateDay(offset: dayOffset, for: firstDay, isWithinDisplayedMonth: isWithinDisplayedMonth) {
                days.append(newDay)
            }
        }
        
        days += generateStartOfNextMonth(using: days[days.count - 1].date)
        
        return days
    }
    
    private func monthMetadata(for date: Date) -> MonthMetadata? {
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: date)?.count else { return nil }
        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return nil }
        let firstDayWeekday = weekday(of: firstDayOfMonth)
        
        return .init(numberOfDaysInMonth: numberOfDaysInMonth,
                     firstDayOfMonth: firstDayOfMonth,
                     firstDayWeekday: firstDayWeekday)
    }
    
    private func generateStartOfNextMonth( using lastDayInMonth: Date) -> [Day] {
        let additionalDays = 7 - weekday(of: lastDayInMonth)
        if additionalDays == 0 { return [] }
        
        var days = [Day]()
        for offset in 1...additionalDays {
            if let newDay = generateDay(offset: offset, for: lastDayInMonth, isWithinDisplayedMonth: false) {
                days.append(newDay)
            }
        }
        
        return days
    }
    
    private func generateDay(offset value: Int, for date: Date, isWithinDisplayedMonth: Bool) -> Day? {
        guard let date = calendar.date(byAdding: .day, value: value, to: date) else { return nil }
        
        return Day(date: date,
                   number: String(calendar.component(.day, from: date)),
//                   isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                   isWithinDisplayedMonth: isWithinDisplayedMonth)
    }
    
    private func weekday(of date: Date) -> Int {
        var result = calendar.component(.weekday, from: date) - 1
        
        if result == 0 {
            result = 7
        }
        
        return result
    }
}
