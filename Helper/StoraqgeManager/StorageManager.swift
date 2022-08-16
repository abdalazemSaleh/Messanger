//
//  UploadPhoto.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-15.
//

import Foundation
import FirebaseStorage

class StorageManager {
    // MARK: - Variables
     static let shared = StorageManager()
     let storage = Storage.storage().reference()
}
