//
//  LoginPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit

// MARK: - Protocol
protocol LoginView: AnyObject {
    func stopAnimation()
    func goToHomeScreen()
}

// MARK: - Presenter
class LoginPresenter {
    // about init & delegation
    public weak var view: LoginView?
    init(view: LoginView) {
        self.view = view
    }
    // MARK: - Login with email
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
    // MARK: - Login with facebook
    // TODO: Refactor this code -
    func loginButtonClicked(myController: UIViewController) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: myController, handler: { [weak self] result, error in
            guard error == nil,
                  let token = result?.token?.tokenString else {
                      return
                  }
            self?.startRequest(token: token)
            
        })
    }
    /// Func start request
    func startRequest(token: String) {
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields": "email, first_name, last_name, picture.type(large)"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        
        facebookRequest.start(completion: { _, result, error in
            guard let result = result as? [String: Any],
                  error == nil else {
                      print("Failed to make graph request")
                      return
                  }
            
            print(result)
            //
            ////            guard let name = result["name"] as? String else {
            ////                print("Problem in name")
            ////                return
            ////            }
            ////
            ////            guard let picture = result["picture"] as? [String: Any],
            ////            let data = picture["data"] as? [String: Any],
            ////            let pictureUrl = data["url"] as? String else {
            ////                print("Problem in picture")
            ////                return
            ////            }
            ////
            ////            guard let email = result["email"] as? String else {
            ////                print("Problem in email")
            ////                return
            ////            }
            ////
            //
            //
            ////            guard let name = result["name"] as? String,
            ////                  let email = result["email"] as? String,
            ////                  let picture = result["picture"] as? [String: Any],
            ////                  let data = picture["data"] as? [String: Any],
            ////                  let pictureUrl = data["url"] as? String else {
            ////                      print("Faield to get email and name from fb result")
            ////                      return
            ////                  }
            ////
            ////            UserDefaults.standard.set(email, forKey: "email")
            ////            UserDefaults.standard.set(name, forKey: "name")
            //
            //
            //            DatabaseManager.shared.userExists(email: email, completion: { exists in
            //
            //                if !exists {
            //
            //                    let chatUser = UserModel(name: name, emailAddress: email)
            //
            //                    DatabaseManager.shared.createNewUser(userModel: chatUser, completion: { success in
            //                        if success {
            //                            guard let url = URL(string: pictureUrl) else {
            //                                return
            //                            }
            //                            print("Downloading data from facebook image")
            //
            //                            URLSession.shared.dataTask(with: url, completionHandler: {  data, _, _ in
            //                                guard let data = data else {
            //                                    print("Failed to get data from facebook")
            //                                    return
            //                                }
            //                                print("got data from FB, uploading...")
            //
            //                                let fileName = chatUser.profilePictureFileName
            //                                StorageManager.shared.uploadPhoto(data: data, fileName: fileName, completion: { result in
            //                                    switch result {
            //                                    case .success(let downloadUrl):
            //                                        UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
            //                                        print(downloadUrl)
            //                                    case .failure(let error):
            //                                        print("Storage manger error: \(error)")
            //                                    }
            //                                })
            //
            //                            }).resume()
            //                        }
            //                    })
            //                }
            //            })
            //            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            //            FirebaseAuth.Auth.auth().signIn(with: credential, completion: { [weak self] authResult, error in
            //                guard let strongSelf = self else {
            //                    return
            //                }
            //
            //                guard authResult != nil, error == nil else {
            //                    if let error = error {
            //                        print("Facebook credential login failed, MFA may be needed - \(error)")
            //                    }
            //                    return
            //                }
            //                UserDefaults.standard.set(email, forKey: "email ")
            //                print("Successfully logged user in")
            //                self?.view?.goToHomeScreen()
            //            })
            //        })
        })

    }
}
                        
                              
                              
                              
                              
