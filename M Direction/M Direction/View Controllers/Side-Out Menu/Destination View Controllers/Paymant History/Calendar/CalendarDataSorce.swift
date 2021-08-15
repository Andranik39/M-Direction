//
//  CalendarDataSorce.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 26.07.2021.
//

import UIKit

extension CalendarPicker: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.id, for: indexPath) as! DayCell
        cell.day = days[indexPath.item]
        return cell
    }
}

extension CalendarPicker: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if days[indexPath.item].isWithinDisplayedMonth {
            if selectedDays.count == 1 {
                calendarPage.selectRange(firstBound: selectedDays[0].indexPath, secondBound: indexPath)
            } else if selectedDays.count == 2 {
                calendarPage.deselectRange()
                selectedDays.removeAll()
            }
        
            selectedDays.append(SelectedDay(indexPath: indexPath, page: pageNumber))
            calendarPage.selectDay(at: indexPath)
//            if let cell = collectionView.cellForItem(at: indexPath) as? DayCell {
//                cell.selectDay()
//            }
        }
        
        return false
    }
}
