//
//  CalendarPage.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 14.08.2021.
//

import UIKit

final class CalendarPage: UICollectionView {
    
    private var selectedItems = [DayCell]()
    private var selectionLines = [UIView]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .systemGroupedBackground
        backgroundView = UIView()
        isScrollEnabled = false
//        alwaysBounceVertical = true
    }
    
    func selectRange(firstBound: IndexPath, secondBound: IndexPath) {
        guard let background = backgroundView else { return }
        
        let lowerBound = min(firstBound, secondBound)
        let upperBound = max(firstBound, secondBound)
        let linesCount = (upperBound.item / 7) - (lowerBound.item / 7)
        
        guard let firstCell = cellForItem(at: lowerBound) as? DayCell else { return }
        guard let secondCell = cellForItem(at: upperBound) as? DayCell else { return }
        
        let firstLine: UIView = {
            let line = UIView()
            line.backgroundColor = .systemTeal
            line.translatesAutoresizingMaskIntoConstraints = false
            background.addSubview(line)
            line.heightAnchor.constraint(equalToConstant: firstCell.size).isActive = true
            line.centerYAnchor.constraint(equalTo: firstCell.centerYAnchor).isActive = true
            line.leadingAnchor.constraint(equalTo: firstCell.centerXAnchor).isActive = true
            selectionLines.append(line)
            
            return line
        }()
        
        if linesCount == 0 {
            firstLine.trailingAnchor.constraint(equalTo: secondCell.centerXAnchor).isActive = true
        } else {
            firstLine.trailingAnchor.constraint(equalTo: background.trailingAnchor).isActive = true
            
            if linesCount > 1 {
                for row in 1..<linesCount {
                    var path = lowerBound
                    path.item += row * 7
                    guard let cell = cellForItem(at: path) as? DayCell else { break }
                    
                    let _: UIView = {
                        let line = UIView()
                        line.backgroundColor = .systemTeal
//                        line.backgroundColor = .systemYellow
//                        line.alpha = 0.4
                        line.pinTo(background, top: nil, bottom: nil)
                        line.heightAnchor.constraint(equalToConstant: cell.size).isActive = true
                        line.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                        selectionLines.append(line)
                        
                        return line
                    }()
                }
            }
            
            let _: UIView = {
                let line = UIView()
                line.backgroundColor = .systemTeal
                line.translatesAutoresizingMaskIntoConstraints = false
                background.addSubview(line)
                line.heightAnchor.constraint(equalToConstant: secondCell.size).isActive = true
                line.centerYAnchor.constraint(equalTo: secondCell.centerYAnchor).isActive = true
                line.trailingAnchor.constraint(equalTo: secondCell.centerXAnchor).isActive = true
                line.leadingAnchor.constraint(equalTo: background.leadingAnchor).isActive = true
                selectionLines.append(line)
                
                return line
            }()
        }
    }
    
    func deselectRange() {
        for item in selectedItems {
            item.deselectDay()
        }
        selectedItems.removeAll()
        
        for line in selectionLines {
            line.removeFromSuperview()
        }
        selectionLines.removeAll()
    }
    
    func selectDay(at indexPath: IndexPath) {
        guard let cell = cellForItem(at: indexPath) as? DayCell else { return }
        cell.selectDay()
        selectedItems.append(cell)
    }
    
//    func deselectDay(at indexPath: IndexPath) {
//        guard let cell = cellForItem(at: indexPath) as? DayCell else { return }
//        cell.deselectDay()
//    }
}
