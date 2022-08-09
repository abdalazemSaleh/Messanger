//
//  Register.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import UIKit
import TransitionButton

class Register: UIViewController {

    // MARK: - Variables
    var presenter: RegisterPresentr!
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegisterPresentr(view: self)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - IBOtlet
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfermationTextField: UITextField!
    @IBOutlet var registerButton: TransitionButton!
    // MARK: - IBAction
    @IBAction func registerButton(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordConfermation = passwordConfermationTextField.text,
              password == passwordConfermation,
              !name.isEmpty, !email.isEmpty, !password.isEmpty else {
                  let alert = Alert.shared.alertUserLoginError(message: "Write correct information")
                  present(alert, animated: true, completion: nil)
                  return
              }
        registerButton.startAnimation()
        presenter.register(name: name, email: email, password: password)
    }
    @IBAction func loginButton(_ sender: UIButton) {
        let vc = Login()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
