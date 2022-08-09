//
//  HandelShadow.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import UIKit

extension UIButton {
    func addShadow() {
       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
   }
    func circleShape() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}
