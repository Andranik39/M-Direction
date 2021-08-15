//
//  PickPhoto.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.07.2021.
//

import UIKit

final class PickPhoto: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var complition: ((String) -> Void)?
    
    private var controller: UIViewController?
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
        let container: UIStackView = {
            let container = UIStackView()
            container.axis = .horizontal
            container.spacing = 20
            container.distribution = .equalSpacing
            container.alignment = .center
            container.pinTo(self)
            
            return container
        }()
        
        title = {
            let title = UILabel()
            title.textColor = UIColor(red: 0.217, green: 0.217, blue: 0.217, alpha: 1)
            title.font = .systemFont(ofSize: 18)
            container.addArrangedSubview(title)
            title.translatesAutoresizingMaskIntoConstraints = false

             return title
        }()
        
        let _: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 0.204, green: 0.812, blue: 0.286, alpha: 1)
            container.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 24).isActive = true
            button.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            button.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchDragExit, .touchCancel])
            
            return button
        }()
    }
    
    @objc private func buttonTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        controller?.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {        
        DispatchQueue.global(qos: .background).async {
            guard let image = info[.originalImage] as? UIImage else { return }
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                self.complition?(jpegData.base64EncodedString())
            }
        }

        controller?.dismiss(animated: true)
    }
    
    func setup(with title: String, for controller: UIViewController) {
        self.controller = controller
        self.title.text = title
    }
}
