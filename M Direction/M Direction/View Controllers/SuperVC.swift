//
//  SuperVC.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 19.06.2021.
//

import UIKit

class GradientedVC: UIViewController {
    
    var content: ContainerView!
    var activeTextField: UITextField?
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupScrollView()
        registerForKeyboardNotifications()
    }
    
    private func setupScrollView() {
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.pinTo(view)
            
            return scrollView
        }()
        
        content = {
            let content = ContainerView()
            content.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(content)
            content.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            content.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            content.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor).isActive = true
            
            return content
        }()
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
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShown(_ notification: Notification) {
        if let info = notification.userInfo, let kbSize = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            if let hiddenField = activeTextField {
                print(hiddenField.frame)
//                let aview = UIView(frame: hiddenField.frame)
//                aview.backgroundColor = .red
//                content.addSubview(aview)
//                let me = CGRect(x: 0, y: content.frame.height - 50, width: 390, height: 50)
//                scrollView.scrollRectToVisible(hiddenField.frame, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillBeHidden() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

final class ContainerView: UIView {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endEditing(true)
    }
}
