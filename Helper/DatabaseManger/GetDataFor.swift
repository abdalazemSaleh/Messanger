//
//  GetDataFor.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-08.
//

import Foundation

// MARK: - Get data
extension DatabaseManager {
    /// Returns dictionary node at child path
    public func getDataFor(path: String, completion: @escaping (Result<Any, Error>) -> Void) {
        database.child("\(path)").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        }
    }
}
