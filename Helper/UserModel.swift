//
//  UserModel.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-07-31.
//

import Foundation

struct UserModel {
    let name: String
    let emailAddress: String

    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
