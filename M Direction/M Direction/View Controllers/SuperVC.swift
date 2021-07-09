//
//  SuperVC.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 19.06.2021.
//

import UIKit

class GradientedVC: UIViewController {
    
    let content = ContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupScrollView()
    }
    
    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.pinTo(view)
//        scrollView.alwaysBounceVertical = true
        
        content.translatesAutoresizingMaskIntoConstraints = false
//        content.backgroundColor = .systemTeal
        scrollView.addSubview(content)
        
        content.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        content.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        content.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        content.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor).isActive = true
    }

    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0.881, green: 0.958, blue: 0.844, alpha: 1).cgColor,
            UIColor(red: 0.842, green: 0.933, blue: 0.799, alpha: 1).cgColor,
            UIColor(red: 0.778, green: 0.867, blue: 0.813, alpha: 1).cgColor
        ]
        gradient.startPoint = .init(x: 0.5, y: 0)
        gradient.endPoint = .init(x: 0.5, y: 1)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
}

final class ContainerView: UIView {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endEditing(true)
    }
}

class IdentifiableUserViewController: GradientedVC {
    var id: Int?
}
