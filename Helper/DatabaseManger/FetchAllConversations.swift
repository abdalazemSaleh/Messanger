//
//  FetchAllConversations.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-14.
//

import Foundation

// MARK: - Fetch all conversations
extension DatabaseManager {
    func getAllConversations(safeEmail: String, completion: @escaping (Result<[ConversationModel], Error>) -> Void) {
        database.child("\(safeEmail)/conversations").observe( .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            let conversations: [ConversationModel] = value.compactMap({ dictionary in
                guard let conversationId = dictionary["id"] as? String,
                    let name = dictionary["name"] as? String,
                    let otherUserEmail = dictionary["other_user_email"] as? String,
                    let latestMessage = dictionary["latest_message"] as? [String: Any],
                    let date = latestMessage["date"] as? String,
                    let message = latestMessage["message"] as? String,
                    let isRead = latestMessage["is_read"] as? Bool else {
                        return nil
                }
                let latestMmessageObject = LatestMessage(date: date,
                                                         text: message,
                                                         isRead: isRead)
                return ConversationModel(id: conversationId,
                                    name: name,
                                    otherUserEmail: otherUserEmail,
                                    latestMessage: latestMmessageObject)
            })
            completion(.success(conversations))
        })
    }
}
