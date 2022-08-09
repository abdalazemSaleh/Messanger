//
//  ViewController.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        validateAuth()
    }
    func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = Login()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let moreVC = Constant.shared.setUpStoryboard(name: "Home").instantiateViewController(identifier: "tabBarScreen")
            moreVC.fullScreenNavigation()
            self.present(moreVC, animated: true, completion: nil)
        }
    }
}

