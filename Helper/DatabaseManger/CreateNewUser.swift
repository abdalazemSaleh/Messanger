//
//  CreateNewUser.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-08.
//

import Foundation

// MARK: - Create new user
extension DatabaseManager {
    /// Creat new user
    func createNewUser(userModel: UserModel, completion: @escaping (Bool) -> Void ) {
        let user = [
            "name": userModel.name
        ]
        creatChild(userModel: userModel, value: user) {  success in
            if success {
                print("Creat user successfuly")
                completion(true)
            } else {
                print("Field to creat user")
                completion(false)
            }
        }
    }
    
    /// Creat child for email
    private func creatChild(userModel: UserModel, value: [String: Any], completion: @escaping (Bool) -> Void) {
        database.child(userModel.safeEmail).setValue(value, withCompletionBlock: { [weak self] error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            print(userModel)
            self?.addUserIntoUsers(userModel: userModel, completion: { success in
                if success {
                    completion(true)
                } else {
                    print("Failed to add user into users")
                    completion(false)
                }
            })
        })
    }
    /// Add  user into users
    private func addUserIntoUsers(userModel: UserModel, completion: @escaping (Bool) -> Void) {
        database.child("users").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            ///  If there is already collection of users append user to this collection
            if var usersCollection = snapshot.value as? [[String: String]] {
                // append to user dictionary
                let newElement = [
                    "name": userModel.name,
                    "email": userModel.safeEmail
                ]
                usersCollection.append(newElement)
                
                self?.addNewUserToUsersCollection(newUser: usersCollection, completion: { success in
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            }
            /// If it's the first user  creat new collection of users
            else {
                self?.creatNewCollection(userModel: userModel, completion: { success in
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            }
        })
    }
    /// Add new user to users collection
    private func addNewUserToUsersCollection(newUser: [[String: Any]], completion: @escaping (Bool) -> Void) {
        database.child("users").setValue(newUser, withCompletionBlock: { error, _ in
            guard error == nil else {
                print("Failed to add new user to users collection")
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// Creat new collection of users
    private func creatNewCollection(userModel: UserModel, completion: @escaping (Bool) -> Void) {
        
        let newCollection: [[String: String]] = [
            [
                "name": userModel.name,
                "email": userModel.safeEmail
            ]
        ]
        database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
}

