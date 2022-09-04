//
//  MessagePresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-08.
//

import Foundation
import MessageKit
import Kingfisher
import AVFoundation
import AVKit

// MARK: - Chat view
protocol chatView: AnyObject {
    func reloadMessageCollection()
    func scrollToLastItem()
    func goToPhotoViewerScreen(url: URL)
    func goToViedoViewer(url: URL)
}

// MARK: - Messanger presenter
class ChatPresenter {
    // about init and delegation
    private weak var view: chatView?
    init(view: chatView) {
        self.view = view
    }
    // Variables
    var messages = [Message]()

    // MARK: - Get all message for conversation
    func getAllMessages(conversationId: String, shouldScrollToBottom: Bool) {
        DatabaseManager.shared.fetchAllMessagesForConversation(id: conversationId, completion: { [weak self] result in
            switch result {
            case .success(let messages):
                print("success in getting messages: \(messages)")
                guard !messages.isEmpty else {
                    print("messages are empty")
                    return
                }
                self?.messages = messages
                
                DispatchQueue.main.async {
                    self?.view?.reloadMessageCollection()
                    if shouldScrollToBottom {
                        self?.view?.scrollToLastItem()
                    }
                }
                
            case .failure(let error):
                print("failed to get messages: \(error)")
            }
        })
    }
    
    // MARK: - Message collection
    /// Number of sections
    func number_ofSections() -> Int {
        return messages.count
    }
    /// Message for item
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    /// Configur media message image view
    func configurMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let message = message as? Message else {
            return
        }
        
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                 return
            }
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl)
        default:
            break
        }
    }
    /// Did tap image
    func didTapImage(indexPath: IndexPath) {
        let message = messages[indexPath.section]
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                 return
            }
            view?.goToPhotoViewerScreen(url: imageUrl)
        case .video(let media):
            guard let videoUrl = media.url else {
                return
            }
            view?.goToViedoViewer(url: videoUrl)
        default:
            break
        }
    }

    // MARK: - Upload photo to storage & send photo messege
    func uploadPhotoMessege(fileName: String, messageId: String, imageData: Data, conversationId: String, reciverEmail: String, reciverName: String, sender: sender) {
        StorageManager.shared.uploadPhotoMessage(data: imageData, fileName: fileName, completion: { [weak self] result in
            switch result {
            case .success(let urlString):
                guard let url = URL(string: urlString) else {
                    return
                }
                self?.sendPhotoMessage(url: url, messegeId: fileName, conversationId: conversationId, reciverEmail: reciverEmail, reciverName: reciverName, sender: sender)
            case .failure(let error):
                print("Failed to upload photo \(error)")
            }
        })
    }
    
    /// Send photo message
    private func sendPhotoMessage(url: URL, messegeId: String, conversationId: String, reciverEmail: String, reciverName: String, sender: sender) {
        /// variables
        guard let placeholder = UIImage(systemName: "photo") else {
            return
        }
        let media = Media(url: url,
                          image: nil,
                          placeholderImage: placeholder,
                          size: .zero)
        
        let message = Message(sender: sender,
                              messageId: messegeId,
                              sentDate: Date(),
                              kind: .photo(media))
        /// send message
        DatabaseManager.shared.sendMessage(conversation: conversationId, reciverEmail: reciverEmail, reciverName: reciverName, message: message, completion: { success in
            if success {
                print("Photo messege send successfuly")
            } else {
                print("Error while sending photo message")
            }
        })
        
    }
    // MARK: - Upload video to storage & send video messege
    func uploadViedoMessege(fileName: String, messageId: String, videoURL: URL, conversationId: String, reciverEmail: String, reciverName: String, sender: sender) {
        StorageManager.shared.uploadvideoMessage(fileUrl: videoURL, fileName: fileName, completion: { [weak self] result in
            switch result {
            case .success(let urlString):
                
                guard let url = URL(string: urlString) else {
                        return
                }
                
                self?.sendVideoMessage(url: url, messegeId: messageId, conversationId: conversationId, reciverEmail: reciverEmail, reciverName: reciverName, sender: sender)
                
            case .failure(let error):
                print("Failed to upload video \(error)")
            }
        })
    }
    
    /// Send photo message
    private func sendVideoMessage(url: URL, messegeId: String, conversationId: String, reciverEmail: String, reciverName: String, sender: sender) {
        /// variables
        guard let placeholder = UIImage(systemName: "photo") else {
            return
        }
        let media = Media(url: url,
                          image: nil,
                          placeholderImage: placeholder,
                          size: .zero)
        
        let message = Message(sender: sender,
                              messageId: messegeId,
                              sentDate: Date(),
                              kind: .video(media))
        /// send message
        DatabaseManager.shared.sendMessage(conversation: conversationId, reciverEmail: reciverEmail, reciverName: reciverName, message: message, completion: { success in
            if success {
                print("Photo messege send successfuly")
            } else {
                print("Error while sending photo message")
            }
        })
    }
    
}
