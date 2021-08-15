//
//  Account.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 03.07.2021.
//

import UIKit

class Account: GradientedVC {
    
    private var menuLeadingAnchor: NSLayoutConstraint!
    
    private var menuButton: UIButton!
    private var coverView: UIView!
    private var rootView: UIView!
    
    private lazy var width = 0.7 * view.frame.width
    private let navigationBarTintColor = UIColor(red: 0.169, green: 0.424, blue: 0.227, alpha: 1)
    private var isMenuPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        
        setupSubviews()
        setupNavigationBar()
        setupCoverView()
        setupSideOutMenu()
//        configureGestures()
        setupSideOutMenuButton()
    }
    
    private func setupNavigationBar() {
        let topView: UIView = {
            let topView = UIView()
            topView.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.65)
            topView.pinTo(view, bottom: nil)
            topView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            return topView
        }()

        let container: UIView = {
            let container = UIView()
            container.backgroundColor = UIColor(red: 0.431, green: 0.725, blue: 0.62, alpha: 0.4)
            container.pinTo(view, top: nil, bottom: nil)
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            container.heightAnchor.constraint(equalToConstant: 70).isActive = true

            return topView
        }()

        let _: UILabel = {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = navigationBarTintColor
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(titleLabel)
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true

            return titleLabel
        }()
        
        view.layoutMargins.top = view.safeAreaInsets.top + 70
    }
    
    private func setupCoverView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        
        coverView = {
            let cover = UIView()
            cover.backgroundColor = .black
            cover.alpha = .zero
            cover.pinTo(rootView)
            cover.addGestureRecognizer(tapGesture)
            
            return cover
        }()
    }
    
    func setupSubviews() {}
    
    private func setupSideOutMenu() {
        let hamburgerMenu = MainMenu()
        hamburgerMenu.navigate = { nextVC in
            self.hideMenu()
            if !nextVC.isMember(of: Self.self) {
                self.navigationController?.setViewControllers([nextVC], animated: true)
            }
        }
        hamburgerMenu.pinTo(rootView, leading: nil, trailing: nil)
        hamburgerMenu.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        menuLeadingAnchor = hamburgerMenu.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: -width)
        menuLeadingAnchor.isActive = true
    }
    
    private func setupSideOutMenuButton() {
        guard let rootView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        menuButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "sidebar.leading"), for: .normal)
            button.tintColor = navigationBarTintColor
            button.addTarget(self, action: #selector(barButtonItemTapped), for: [.touchUpInside, .touchDragExit, .touchCancel])
            button.translatesAutoresizingMaskIntoConstraints = false
            rootView.addSubview(button)
            button.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 15).isActive = true
            button.centerYAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
            
            return button
        }()
    }
    
//    private func configureGestures() {
//        let swipeLeftGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
//        swipeLeftGesture.edges = .left
//        view.addGestureRecognizer(swipeLeftGesture)
//
////        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
////        view.addGestureRecognizer(tapGesture)
//    }
//
//    @objc private func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
//        if recognizer.state == .recognized {
//            showMenu()
//        }
////        if recognizer.state == .began {
////            print("Began")
////        } else if recognizer.state == .changed {
////            print(recognizer.translation(in: view).x)
////        } else if recognizer.state == .ended {
////            print("Ended")
////        }
//    }
    
    @objc private func barButtonItemTapped() {
        isMenuPresented ? hideMenu(): showMenu()
    }
    
    @objc private func showMenu() {
        isMenuPresented = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.menuLeadingAnchor.constant = 0
            self.coverView.alpha = 0.4
            self.rootView.layoutIfNeeded()
        }
    }
    
    @objc private func hideMenu() {
        isMenuPresented = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.menuLeadingAnchor.constant -= self.width
            self.coverView.alpha = .zero
            self.rootView.layoutIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        menuButton.removeFromSuperview()
    }
}
