//
//  FetchAllMessages.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-14.
//

import Foundation
import UIKit

extension DatabaseManager {
    func fetchAllMessagesForConversation(id: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        database.child("\(id)/messages").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            let messages: [Message] = value.compactMap({ dictionary in
                guard let name = dictionary["name"] as? String,
//                    let isRead = dictionary["is_read"] as? Bool,
                    let messageID = dictionary["id"] as? String,
                    let content = dictionary["content"] as? String,
                    let senderEmail = dictionary["sender_email"] as? String,
//                    let type = dictionary["type"] as? String,
                    let dateString = dictionary["date"] as? String,
                    let date = UIViewController.dateFormatter.date(from: dateString)else {
                        return nil
                }
                
                let sender = sender(senderId: senderEmail,
                                    displayName: name,
                                    photoUrl: "")
                return Message(sender: sender,
                               messageId: messageID,
                               sentDate: date,
                               kind: .text(content))
            })
            completion(.success(messages))
            
        })
    }
}
