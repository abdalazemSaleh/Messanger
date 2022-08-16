//
//  Chat+InputAccessory.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-11.
//

import Foundation
import InputBarAccessoryView

extension Chat: InputBarAccessoryViewDelegate {
    
    // MARK: - Set up input accessory
    func setUpInputAccessory() {
        messageInputBar.delegate = self
    }
    
    // MARK: - Delegate
    // TODO: Refactoring -
    /// input bar
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
              let sender = selfSender,
              let messageId = creatMessageId() as? String else {
                  return
              }
        print("Sending: \(text)")
        let message = Message(sender: sender,
                              messageId: messageId,
                              sentDate: Date(),
                              kind: .text(text))
        /// Send message
        if isNewConversatoin {
            /// Creat new conversation in database
            createNewConverastion(message: message)
        } else {
            /// Append to exists conversation
            guard let conversationId = conversationId, let name = self.title else {
                return
            }
            DatabaseManager.shared.sendMessage(conversation: conversationId, reciverEmail: reciverEmail, reciverName: name, message: message, completion: { [weak self] success in
                if success {
                    self?.messageInputBar.inputTextView.text = nil
                    print("message sent")
                }
                else {
                    print("failed to send")
                }
            })
        }
    }
    /// Create new conversation
    func createNewConverastion(message: Message) {
        DatabaseManager.shared.creatNewConversation(receiverEmail: reciverEmail, receivername: self.title ?? "User", firstMessage: message, completion: { [weak self] success in
            if success {
                print("Message sent successfuly")
                self?.isNewConversatoin = false
            } else {
                print("Faield to send")
            }
        })
    }
    
    /// Create message id
    func creatMessageId() -> String {
        // We will using: - Date, Sender email, Reciver email, random int
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return ""
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        let dateString = UIViewController.dateFormatter.string(from: Date())
        let newIdentifier = "ReciverEmail_inHere_\(safeEmail)_\(dateString)"
        print(newIdentifier)
        return newIdentifier
    }
    
    
}
