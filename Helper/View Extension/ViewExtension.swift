//
//  ViewExtention.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

/// Present full screen
extension UIViewController {
    func fullScreenNavigation() {
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
}

/// Add sadow 
extension UIView {
     func addShadowToView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
}
