//
//  Profile.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit
import FirebaseAuth

class Profile: UIViewController {

    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        handelUserImage()
        handelLogoutButton()
    }
    // MARK: - IBOutlet
    @IBOutlet var user_image: UIImageView!
    @IBOutlet var logoutButton: UIButton!
    // MARK: - IBAction
    @IBAction func logoutButton(_ sender: UIButton) {
        logout()
    }
    // MARK: - Logout
    func logout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print("Error")
        }
        
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
