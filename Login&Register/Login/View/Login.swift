//
//  Login.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import UIKit
import TransitionButton

class Login: UIViewController {
    
    // MARK: - Variables
    var presnter: LoginPresenter!
    
//    private let facebookLoginButton: FBLoginButton = {
//        let button = FBLoginButton()
//        button.permissions = ["email", "public_profile"]
//        return button
//    }()

    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookButton.circleShape()
        twitterButton.circleShape()
        twitterButton.addShadow()
        facebookButton.addShadow()
        loginButton.layer.cornerRadius = 16
        presnter = LoginPresenter(view: self)
        self.navigationController?.isNavigationBarHidden = true
    }

    
    // MARK: - IBOutlet
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: TransitionButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var twitterButton: UIButton!
    // MARK: - IBAction
    @IBAction func loginButtom(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty, !password.isEmpty else {
                  let alert = Alert.shared.alertUserLoginError(message: "Check information")
                  return self.present(alert, animated: true, completion: nil)
              }
        loginButton.startAnimation()
        presnter.login(email: email, password: password)
    }
    @IBAction func registerButton(_ sender: UIButton) {
        let vc = Register()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
        presnter.loginButtonClicked(myController: self)
    }
}
