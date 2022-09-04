//
//  isConversationExsists!.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-09-02.
//

import Foundation

extension DatabaseManager {
    func isConversationExists(recipientEmail: String, completion: @escaping (Result<String, Error>) -> Void) {
        let safeRecipientEmail = DatabaseManager.safeEmail(emailAddress: recipientEmail)
        let senderEmail = Constant.shared.getUserSafeEmail()
        
        database.child("\(safeRecipientEmail)/conversations").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let conversations = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                 return
            }
            
            self?.checkTargetConversation(senderEmail: senderEmail, conversations: conversations, completion: { result in
                switch result {
                case .success(let id):
                    completion(.success(id))
                case .failure(let error):
                    print("Failed to check targer conversation \(error)")
                }
            })
        })
    }
    /// Check if target conversation
    private func checkTargetConversation(senderEmail: String, conversations: [[String: Any]], completion: @escaping (Result<String, Error>) -> Void) {
        if let targetConversation = conversations.first(where: {
            guard let targetUserEmail = $0["other_user_email"] as? String else {
                return false
            }
            return senderEmail == targetUserEmail
        }) {
            /// Get conversation id
            guard let id = targetConversation["id"] as? String else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(id))
        }
        completion(.failure(DatabaseError.failedToFetch))
    }
}
