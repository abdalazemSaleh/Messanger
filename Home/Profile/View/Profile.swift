//
//  Profile.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit
import Kingfisher

class Profile: UIViewController {

    // MARK: - Variables
    var presenter: ProfilePresenter!
    let name = UserDefaults.standard.value(forKey: "name")
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter(view: self)
        handelUserImage()
        handelLogoutButton()
        imageTap_in()
        presenter.downloadPhoto()
        setUserName()
    }
    
    // MARK: - IBOutlet
    @IBOutlet var user_image: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var logoutButton: UIButton!
    // MARK: - IBAction
    @IBAction func logoutButton(_ sender: UIButton) {
        presenter.logout()
    }
    // MARK: - Handel image tapped in
    func imageTap_in() {
        user_image.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(changeProfilePic))
        user_image.addGestureRecognizer(gesture)
    }
    @objc func changeProfilePic() {
        presenter.presentPhotoActionSheet()
    }
    // MARK: - Set user name
    func setUserName() {
        guard let name = name as? String else {
            return
        }
        userName.text = name
    }
    // MARK: - Handel view
    /// User_image
    func handelUserImage() {
        user_image.layer.borderWidth = 2
        user_image.layer.borderColor = UIColor(named: "Color")?.cgColor
        user_image.layer.cornerRadius = user_image.frame.size.width/2
        user_image.clipsToBounds = true
    }
    /// Add border to logout button
    func handelLogoutButton() {
        logoutButton.layer.cornerRadius = 16
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = UIColor(named: "Color")?.cgColor
        
    }
    
}
