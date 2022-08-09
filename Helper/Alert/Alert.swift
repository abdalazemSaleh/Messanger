//
//  Alert.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import UIKit

class Alert {
    static let shared = Alert()
    
    func alertUserLoginError(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel,
                                      handler: nil))
        return alert
    }
    
}

