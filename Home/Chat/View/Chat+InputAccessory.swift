//
//  Chat+InputAccessory.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-11.
//

import Foundation
import InputBarAccessoryView
import UIKit

extension Chat: InputBarAccessoryViewDelegate {
    

    
    #warning("Refactorin this code")
    // TODO: Refactoring -
    func setUpinputButton() {
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 35, height: 35), animated: true)
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.onTouchUpInside({ [weak self] _ in
            self?.presentActionSheet()
        })
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: true, animations: nil)
        messageInputBar.setStackViewItems([button], forStack: .left, animated: true)
    }

    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Attach Media",
                                            message: "What would you like to attach",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoActionShhet()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Video", style: .default, handler: { [weak self] _ in
            self?.presentVideoActionShhet()
        }))

        
        actionSheet.addAction(UIAlertAction(title: "Audio", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)

    }
    
    func presentPhotoActionShhet() {
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "where would you need to attach photo from",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    /// Present viedo action sheet
    func presentVideoActionShhet() {
        let actionSheet = UIAlertController(title: "Attach Video",
                                            message: "where would you need to attach Video from",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.mediaTypes = ["public.movie"]
            picker.videoQuality = .typeMedium
            picker.allowsEditing = true
            self?.present(picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.mediaTypes = ["public.movie"]
            picker.videoQuality = .typeMedium
            picker.allowsEditing = true
            self?.present(picker, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - End in here    
    
    // MARK: - Set up input accessory
    func setUpInputAccessory() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.backgroundColor = .lightGray
        messageInputBar.inputTextView.layer.cornerRadius = 16
    }
    
    // MARK: - Delegate
    // TODO: Refactoring -
    /// input bar
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
              let sender = selfSender else {
                  return
              }
        let messageId = creatMessageId()
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
