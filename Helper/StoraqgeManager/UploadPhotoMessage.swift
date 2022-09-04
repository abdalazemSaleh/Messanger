//
//  UploadPhotoMessage.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-26.
//

import Foundation


extension StorageManager {
    /// Uload message photo
    func uploadPhotoMessage(data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                completion(.failure(StorageManagerError.FailedToUpload))
                return
            }
            /// Downlod message photo
            self?.downloadPhotoMessage(fileName: fileName, completion: { result in
                switch result {
                case.success(let url):
                    completion(.success(url))
                case .failure(let error):
                    print(error)
                }
            })
        })
    }
    /// Download message photo
    private func downloadPhotoMessage(fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_images/\(fileName)").downloadURL(completion: { url, error in
            guard let url = url else {
                completion(.failure(StorageManagerError.FailedToDownload))
                return
            }
            let urlString = url.absoluteString
            completion(.success(urlString))
        })
    }
}
