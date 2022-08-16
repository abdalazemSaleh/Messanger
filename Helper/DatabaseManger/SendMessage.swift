//
//  SendMessage.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-11.
//

import Foundation
import UIKit

// MARK: - Send message
// TODO: Need some refactoring -

extension DatabaseManager {
    func sendMessage(conversation: String, reciverEmail: String, reciverName: String, message: Message, completion: @escaping (Bool) -> (Void)) {
        // We will : - Send message & updateSender latest message & update reciver latest message
        /// Get user current email
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        print(safeEmail)
        /// Get conversation
        getConversation(conversation: conversation, newMessage: message, name: reciverName, safeEmail: safeEmail, reciverEmail: reciverEmail, reciverName: reciverName, completion: { success in
            if success {
                print("Success to get conversation & add new message")
            } else {
                completion(false)
                print("Failed to get conversation & add new message")
            }
        })
    }
    
    /// Get converation
    func getConversation(conversation: String, newMessage: Message, name: String, safeEmail: String, reciverEmail: String, reciverName: String, completion: @escaping (Bool) -> (Void)) {
        database.child("\(conversation)/messages").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard var currentMessages = snapshot.value as? [[String: Any]] else {
                return
            }
            
            /// Get message date
            let messageDate = newMessage.sentDate
            let dateString = UIViewController.dateFormatter.string(from: messageDate)
            
            /// Get message kind
            guard let message = self?.messageKinde(message: newMessage) else {
                print("Failed to get message")
                return
            }
            
            /// New message entry
            let newMessage: [String: Any] = [
                "id": newMessage.messageId,
                "type": newMessage.kind.messageKind,
                "content": message,
                "date": dateString,
                "sender_email": safeEmail,
                "is_read": false,
                "name": name
            ]
            
            /// Append new message to current messages
            currentMessages.append(newMessage)
            self?.appendNewMessageToCurrentMessages(conversation: conversation, currentMessages: currentMessages, safeEmail: safeEmail, message: message, date: dateString, reciverEmail: reciverEmail, reciverName: reciverName, completion: { success in
                if success {
                    print("Append message successfuly")
                } else {
                    completion(false)
                    print("Failed to append message")
                }
            })
            
        })
    }
    
    /// Append new message to current messages
    func appendNewMessageToCurrentMessages(conversation: String, currentMessages: [[String: Any]], safeEmail: String, message: String, date: String, reciverEmail: String, reciverName: String, completion: @escaping (Bool) -> (Void)) {
        database.child("\(conversation)/messages").setValue(currentMessages, withCompletionBlock: { [weak self] error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            /// Update latest message
            self?.updateLatestMessage(safeEmail: safeEmail, message: message, date: date,conversation: conversation, reciverEmail: reciverEmail, reciverName: reciverName, completion: { success in
                if success {
                    print("Update latest message successfuly")
                } else {
                    print("Failed to update latest message")
                }
            })
        })
    }
    
    /// Update latest message
    func updateLatestMessage(safeEmail: String, message: String, date: String, conversation: String, reciverEmail: String, reciverName: String, completion: @escaping (Bool) -> Void) {
        
        database.child("\(safeEmail)/conversations").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            var databaseEnteryConversations = [[String:Any]]()
            let latestMessage: [String: Any] = [
                "message": message,
                "date": date,
                "is_read": false
            ]
            
            if var currentUserConversations = snapshot.value as? [[String: Any]] {
                var targetConversation: [String: Any]?
                var position = 0
                
                for conversationDictionary in currentUserConversations {
                    if let currentId = conversationDictionary["id"] as? String, currentId == conversation {
                        targetConversation = conversationDictionary
                    }
                    
                    if var targetConversation = targetConversation {
                        targetConversation["latest_message"] = latestMessage
                        currentUserConversations[position] = targetConversation
                        databaseEnteryConversations = currentUserConversations
                    } else {
                        let newConversationData: [String: Any] = [
                            "id": conversation,
                            "other_user_email": DatabaseManager.safeEmail(emailAddress: reciverEmail),
                            "name": "",
                            "latest_message": latestMessage
                        ]
                        currentUserConversations.append(newConversationData)
                        databaseEnteryConversations = currentUserConversations
                    }
                }
            } else {
                let newConversationData: [String: Any] = [
                    "id": conversation,
                    "other_user_email": DatabaseManager.safeEmail(emailAddress: reciverEmail),
                    "name": "",
                    "latest_message": latestMessage
                ]
                databaseEnteryConversations = [
                    newConversationData
                ]
            }
            self?.database.child("\(safeEmail)/conversations").setValue(databaseEnteryConversations, withCompletionBlock: { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
            })
            /// Update recipent latest message
            self?.updateRecipientLatestMessage(conversation: conversation, reciverEmail: reciverEmail, safeEmail: safeEmail, message: message, date: date, completion: { success in
                if success {
                    print("Update recipient latest message successfuly")
                } else {
                    print("Failed to update recipient message")
                }
            })
            
        })
    }
    /// Update recipient latest mesage
    func updateRecipientLatestMessage(conversation: String, reciverEmail: String, safeEmail: String, message: String, date: String, completion: @escaping (Bool) -> Void) {
        database.child("\(reciverEmail)/conversations").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            let updatedValue: [String: Any] = [
                "date": date,
                "is_read": false,
                "message": message
            ]
            var databaseEntryConversations = [[String: Any]]()
            
            guard let currentName = UserDefaults.standard.value(forKey: "name") as? String else {
                return
            }
            
            if var otherUserConversations = snapshot.value as? [[String: Any]] {
                var targetConversation: [String: Any]?
                var position = 0
                
                for conversationDictionary in otherUserConversations {
                    if let currentId = conversationDictionary["id"] as? String, currentId == conversation {
                        targetConversation = conversationDictionary
                        break
                    }
                    position += 1
                }
                
                if var targetConversation = targetConversation {
                    targetConversation["latest_message"] = updatedValue
                    otherUserConversations[position] = targetConversation
                    databaseEntryConversations = otherUserConversations
                }
                else {
                    // failed to find in current colleciton
                    let newConversationData: [String: Any] = [
                        "id": conversation,
                        "other_user_email": DatabaseManager.safeEmail(emailAddress: safeEmail),
                        "name": currentName,
                        "latest_message": updatedValue
                    ]
                    otherUserConversations.append(newConversationData)
                    databaseEntryConversations = otherUserConversations
                }
            }
            else {
                // current collection does not exist
                let newConversationData: [String: Any] = [
                    "id": conversation,
                    "other_user_email": DatabaseManager.safeEmail(emailAddress: safeEmail),
                    "name": currentName,
                    "latest_message": updatedValue
                ]
                databaseEntryConversations = [
                    newConversationData
                ]
            }
            
            self?.database.child("\(reciverEmail)/conversations").setValue(databaseEntryConversations, withCompletionBlock: { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        })
    }
}
