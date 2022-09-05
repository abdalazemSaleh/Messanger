//
//  CreateNewConversation.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-08.
//

import Foundation
import UIKit

extension DatabaseManager {
    // MARK: -  Create new conversation
    func creatNewConversation(receiverEmail: String, receivername: String, firstMessage: Message, completion: @escaping (Bool) -> Void)  {
        /// Check user email & name
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String,
              let currentName = UserDefaults.standard.value(forKey: "name") as? String else {
                  return
              }
        /// Make user email safe
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        /// get ref
        let refrance = database.child("\(safeEmail)")
        ///  Make new conversation
        refrance.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            /// Check if recever user is already found
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                print("user not found :(")
                return
            }
            /// Variables: - message date & converastion id & message data
            let messageDate = firstMessage.sentDate
            let dateString = UIViewController.dateFormatter.string(from: messageDate)
            let message = self?.messageKinde(message: firstMessage)
            print(message as Any)
            let conversationId = "conversation_\(firstMessage.messageId)"
            /// New conversation data
            let newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": receiverEmail,
                "name": receivername,
                "latest_message": [
                    "date": dateString,
                    "message": message as Any,
                    "is_read": false
                ]
            ]
            /// Recipient conversation data
            let recipient_newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": safeEmail,
                "name": currentName,
                "latest_message": [
                    "date": dateString,
                    "message": message as Any,
                    "is_read": false
                ]
            ]
            /// Update recipient conversaiton arry
            self?.updateRecipientConversationsArry(Conversation: recipient_newConversationData, receiverEmail: receiverEmail)
            /// Update current user conversation arry
            if var conversations = userNode["conversations"] as? [[String: Any]] {
                /// Append to conversations arry
                conversations.append(newConversationData)
                userNode["conversations"] = conversations
                refrance.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    /// Finsh conversation
                    self?.finshCreatingConversation(name: currentName, conversationId: conversationId, firstMessage: firstMessage, completion: completion)
                })
            } else {
                /// Make new conversations arry
                userNode["conversations"] = [
                    newConversationData
                ]
                refrance.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    /// Finsh conversation
                    self?.finshCreatingConversation(name: currentName, conversationId: conversationId, firstMessage: firstMessage, completion: completion)
                })
                
            }
        })
    }
    
    // MARK: -  Update recipient conversations arry
    func updateRecipientConversationsArry(Conversation: [String: Any], receiverEmail: String) {
        database.child("\(receiverEmail)/conversations").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            /// Check if there is conversations
            if var conversations = snapshot.value as? [[String: Any]]  {
                /// Append to conversations
                conversations.append(Conversation)
                self?.database.child("\(receiverEmail)/conversations").setValue(conversations)
            } else {
                /// Create new conversations arry
                self?.database.child("\(receiverEmail)/conversations").setValue([Conversation])
            }
        })
    }
    // MARK: -
    // TODO: - Update current user conversation arry
    func updateCurrentUserConversationArry(newConversation: [String: Any], value: [String: Any], currentEmail: String, name: String, messageId: String, firstMessage: Message) {
        }
    
    // MARK: - Finsh creating converations
    func finshCreatingConversation(name: String, conversationId: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        /// Message date
        let messageDate = firstMessage.sentDate
        let dateString = UIViewController.dateFormatter.string(from: messageDate)
        /// Message kind
        let message = messageKinde(message: firstMessage)
        print(message)
        /// Check current email
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        /// Message arry
        let collectionMessage: [String: Any] = [
            "id": firstMessage.messageId,
            "type": firstMessage.kind.messageKind,
            "content": message,
            "date": dateString,
            "sender_email": safeEmail,
            "is_read": false,
            "name": name
        ]
        let value: [String: Any] = [
            "messages": [
                collectionMessage
            ]
        ]
        print("Adding conversation: \(conversationId)")
        /// Create child for conversation id
        database.child("\(conversationId)").setValue(value, withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    // MARK: -  Message kind
    func messageKinde(message: Message) -> String {
        var firsMessage = ""
        switch message.kind {
        case .text(let messageText):
            firsMessage = messageText
        case .attributedText(_):
            break
        case .photo(let mediaItem):
            if let targetUrlString = mediaItem.url?.absoluteString {
                firsMessage = targetUrlString
            }
            break
        case .video(let mediaItem):
            if let targetUrlString = mediaItem.url?.absoluteString {
                firsMessage = targetUrlString
            } 
            break
        case .location(let locationData):
            let location = locationData.location
            firsMessage = "\(location.coordinate.longitude),\(location.coordinate.latitude)"
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        return firsMessage
    }
    
    
}
