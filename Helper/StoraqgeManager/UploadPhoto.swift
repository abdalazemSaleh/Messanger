//
//  UploadPhoto.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-15.
//

import Foundation

extension StorageManager {
    
    /// Upload photo to storage manager
    func uploadPhoto(data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        /// Upload photo
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                completion(.failure(StorageManagerError.FailedToUpload))
                return
            }
            print("Upload successed")
        })
    }

    /// Download photo
    func downloadPhoto(fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("images/\(fileName)").downloadURL(completion: { url, error in
            guard let url = url else {
                completion(.failure(StorageManagerError.FailedToDownload))
                return
            }
            let urlString = url.absoluteString
            completion(.success(urlString))
        })
    }
}
