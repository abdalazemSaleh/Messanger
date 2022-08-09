//
//  LoginPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation
import FirebaseAuth

// MARK: - Protocol
protocol LoginView: AnyObject {
    func stopAnimation()
    func goToHomeScreen()
}

// MARK: - Presenter
class LoginPresenter {
    // about init & delegation
    private weak var view: LoginView?
    init(view: LoginView) {
        self.view = view
    }
    /// Login function
    func login(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard  error == nil else {
                print("Failed to login")
                return
            }
            let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
            DatabaseManager.shared.getDataFor(path: safeEmail, completion: { result in
                switch result {
                case .success(let data):
                    print("my_data_is: - \(data)")
                    guard let userData = data as? [String: Any],
                    let name = userData["name"] as? String else {
                        return
                    }
                    UserDefaults.standard.set(name, forKey: "name")
                case .failure(let error):
                    print("Failed to login \(error)")
                }
            })
            self?.view?.stopAnimation()
            UserDefaults.standard.set(email, forKey: "email")
            print(authResult?.user ?? "")
            print("login success")
            self?.view?.goToHomeScreen()
        })
    }
}


