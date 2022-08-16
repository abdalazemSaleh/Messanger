//
//  Profile+Picker.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-15.
//

import Foundation
import UIKit


extension Profile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Did finish picking media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.user_image.image = selectedImage
    }

    /// image picker did canse
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
