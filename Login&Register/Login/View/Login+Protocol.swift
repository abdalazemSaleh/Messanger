//
//  Login+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation

extension Login: LoginView {
    /// Go to home screen
    func goToHomeScreen() {
            let moreVC = Constant.shared.setUpStoryboard(name: "Home").instantiateViewController(identifier: "tabBarScreen")
            moreVC.fullScreenNavigation()
            self.present(moreVC, animated: true, completion: nil)
    }
    /// Stop animation
    func stopAnimation() {
        loginButton.stopAnimation()
    }
}
