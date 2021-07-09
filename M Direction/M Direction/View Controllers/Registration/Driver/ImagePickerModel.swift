//
//  ImagePickerModel.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 03.07.2021.
//

import UIKit

final class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static var shared = ImagePickerCoordinator()
    var stringValue: String?
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            stringValue = jpegData.base64EncodedString(options: .endLineWithLineFeed)
        }

        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
