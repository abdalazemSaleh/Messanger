//
//  Register+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation

extension Register: RegisterView {
    /// Present alert
    func presentAlert() {
        let alert = Alert.shared.alertUserLoginError(message: "This account already exists")
        present(alert, animated: true, completion: nil)
    }
    /// Stop animation
    func stopAnimation() {
        registerButton.stopAnimation()
    }
    /// Go to home screen
    func goToHomeScreen() {
            let moreVC = Constant.shared.setUpStoryboard(name: "Home").instantiateViewController(identifier: "tabBarScreen")
            moreVC.fullScreenNavigation()
            self.present(moreVC, animated: true, completion: nil)
    }
}
