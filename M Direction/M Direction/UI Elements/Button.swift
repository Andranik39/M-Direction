//
//  Button.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 19.06.2021.
//

import UIKit

class Button: UIControl {
    
    private var title: UILabel!
//    private var animator = UIViewPropertyAnimator()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    private func setupSubviews() {
        setupGradient()
//        backgroundColor = .systemTeal
        
        title = {
            let title = UILabel()
            title.textColor = .white
            title.font = .systemFont(ofSize: 24)
            title.translatesAutoresizingMaskIntoConstraints = false
            addSubview(title)
            title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            return title
        }()

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true

//        addTarget(self, action: #selector(becomePressed), for: [.touchDown, .touchDragEnter])
//        addTarget(self, action: #selector(returnOriginalState), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    private func setupGradient() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.colors = [
            UIColor(red: 0.443, green: 0.721, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.058, green: 0.854, blue: 0.09, alpha: 0.97).cgColor
          ]
        gradientLayer.startPoint = .init(x: 0, y: 0)
        gradientLayer.endPoint = .init(x: 1, y: 1)
        gradientLayer.cornerRadius = 25
        gradientLayer.cornerCurve = .circular
        gradientLayer.shadowColor = UIColor(red: 0.094, green: 0.271, blue: 0.079, alpha: 0.2).cgColor
        gradientLayer.shadowRadius = 5
        gradientLayer.shadowOpacity = 1
        gradientLayer.shadowOffset = .zero
    }

//    @objc private func becomePressed() {
//        animator.stopAnimation(true)
////        backgroundColor = .systemYellow
//        transform = .init(scaleX: 0.95, y: 0.95)
//    }
//
//    @objc private func returnOriginalState() {
//        animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut) {
////            self.backgroundColor = .systemTeal
//            self.transform = .identity
//        }
//        animator.startAnimation()
//    }
    
    func setup(with text: String) {
        title.text = text
    }
}
