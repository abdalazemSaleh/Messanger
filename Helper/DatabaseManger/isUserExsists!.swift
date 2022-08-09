//
//  isUserExsists!.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-08.
//

import Foundation

// MARK: - Check if user exists
extension DatabaseManager {
    func userExists(email: String, completion: @escaping ((Bool) -> Void)) {
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? [String: Any] != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
}

