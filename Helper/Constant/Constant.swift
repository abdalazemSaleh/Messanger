//
//  Constant.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit


class Constant {
    
    static let shared = Constant()
    
    func setUpStoryboard(name: String) -> UIStoryboard {
        let storyBoard = UIStoryboard.init(name: name, bundle: Bundle.main)
        return storyBoard
    }
    
    func getUserSafeEmail() -> String {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return ""
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        return safeEmail
    }
}
