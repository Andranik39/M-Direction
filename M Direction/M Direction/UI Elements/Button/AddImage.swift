//
//  AddImage.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 30.06.2021.
//

import UIKit

final class AddImage: UIControl {
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        imageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "plus.circle.fill")
            imageView.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
                        
            leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            
            return imageView
        }()
        addTarget(self, action: #selector(identity), for: [.touchUpInside, .touchDragExit, .touchCancel])
        addTarget(self, action: #selector(press), for: [.touchDown, .touchDragEnter])
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func press() {
        imageView.tintColor = .systemBlue
    }
    
    @objc private func identity() {
        imageView.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
    }
}
