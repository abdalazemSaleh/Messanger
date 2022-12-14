//
//  ProfilePresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-15.
//

import Foundation
import FirebaseAuth

protocol ProfileView: AnyObject {
    func presentActionSheet(sheet: UIAlertController)
    func presentPhotoPicker()
    func presentCamera()
    func getPhoto() -> UIImageView
    func setProfilePicture(url: String)
    func finishLogout()
}

class ProfilePresenter {
    // about init and delegation
    private weak var view: ProfileView?
    init(view: ProfileView) {
        self.view = view
    }
    // Code
    //MARK: -  Upload image to firebase storage
    func upload_image(image: UIImageView) {
        /// Get safe email
        let safeEmail = Constant.shared.getUserSafeEmail()
        /// Convert image to png data
        guard let image = image.image,
        let data = image.pngData() else {
            return
        }
        
        /// Make file name for image
        let fileName = "\(safeEmail)_profile_picture.png"
        /// Upload image
        StorageManager.shared.uploadPhoto(data: data, fileName: fileName, completion: { result in
            switch result {
            case .success(let url):
                print(url)
            case .failure(let error):
                print("\(error)")
            }
        })
    }
    //MARK: - Download photo from firbase storage
    func downloadPhoto() {
        /// Get file name
        let safeEmail = Constant.shared.getUserSafeEmail()
        let fileName = "\(safeEmail)_profile_picture.png"
        print(safeEmail)
        StorageManager.shared.downloadPhoto(fileName: fileName, completion: { [weak self] result in
            switch result {
            case .success(let url):
                self?.view?.setProfilePicture(url: url)
            case .failure(let error):
                print("\(error)")
            }
        })
    }

    //MARK: - Log out
    func logout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            view?.finishLogout()
        } catch {
            print("Error")
        }
    }
        
    //MARK: - Present photo action cheet
    func presentPhotoActionSheet() {
        let actionSheet = actionSheet()
        view?.presentActionSheet(sheet: actionSheet)
    }
        
    /// Action sheet
    func actionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cansel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Chose photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.view?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Take photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.view?.presentCamera()
        }))
        return actionSheet
    }

}
