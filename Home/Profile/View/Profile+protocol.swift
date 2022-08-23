//
//  Profile+protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-15.
//

import Foundation
import UIKit

extension Profile: ProfileView {
    
    /// Present action sheer
    func presentActionSheet(sheet: UIAlertController) {
        present(sheet, animated: true, completion: nil)
    }
    
    /// Present picker view
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    /// Present Camera
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    /// Return image view
    func getPhoto() -> UIImageView {
        return user_image
    }
    
    /// Set profile picture
    func setProfilePicture(url: String) {
        let imageUrl = URL(string: url)
        user_image.kf.indicatorType = .activity
        user_image.kf.setImage(with: imageUrl)
    }
    
    /// Finish logout
    func finishLogout() {
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.setValue(nil, forKey: "name")

        let vc = Login()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
