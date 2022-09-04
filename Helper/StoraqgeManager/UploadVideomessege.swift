//
//  UploadVideomessege.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-27.
//

import Foundation

extension StorageManager {
    /// Uload message photo
    func uploadvideoMessage(fileUrl: URL, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_videos/\(fileName)").putFile(from: fileUrl, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                completion(.failure(StorageManagerError.FailedToUpload))
                return
            }
            /// Downlod message photo
            self?.downloadVideoMessage(fileName: fileName, completion: { result in
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
    private func downloadVideoMessage(fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_videos/\(fileName)").downloadURL(completion: { url, error in
            guard let url = url else {
                completion(.failure(StorageManagerError.FailedToDownload))
                return
            }
            let urlString = url.absoluteString
            completion(.success(urlString))
        })
    }
}
