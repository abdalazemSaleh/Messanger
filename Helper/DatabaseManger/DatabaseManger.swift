//
//  DatabaseManger.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    /// Shared instance of class
    public static let shared = DatabaseManager()
    /// get refrance from my database
    public let database = Database.database().reference()
    /// Handel safe email
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}

