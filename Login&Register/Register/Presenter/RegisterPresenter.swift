//
//  RegisterPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation
import FirebaseAuth

// MARK: - Protocol
protocol RegisterView: AnyObject {
    func presentAlert()
    func stopAnimation()
    func goToHomeScreen()
}

// MARK: - Presenter
class RegisterPresentr {
    // about init & delegation
    private weak var view: RegisterView?
    init(view: RegisterView) {
        self.view = view
    }
    // Register func
    func register(name: String, email: String, password: String) {
        DatabaseManager.shared.userExists(email: email, completion: { [weak self] exists in
            /// Check if user is already exists
            guard !exists else {
                self?.view?.stopAnimation()
                self?.view?.presentAlert()
                return
            }
            self?.creatUserAuth(name: name, email: email, password: password)
        })
    }
    /// Creat user auth
    private func creatUserAuth(name: String, email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                print("Error while creating user")
                return
            }
        })
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(name, forKey: "name")
        
        DatabaseManager.shared.createNewUser(userModel: UserModel(name: name, emailAddress: email), completion: { [weak self] success in
            if success {
                self?.view?.stopAnimation()
                print("Creat user successfuly")
                self?.view?.goToHomeScreen()
            }
        })
    }
}
