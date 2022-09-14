//
//  Chat+Messagekit.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-10.
//

import UIKit
import MessageKit

extension Chat: MessagesLayoutDelegate, MessagesDataSource, MessagesDisplayDelegate {
    
    // MARK: - Set up message layout delegate & datasource & displaydelegate
    func setUpMessageLayoutAndDisplayDelegateAndDatasource() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.delegate = self
    }
    // MARK: - Delegate & data source
    /// Current sender
    func currentSender() -> SenderType {
        if let sender = selfSender {
            return sender
        }
        fatalError("self sender is nil")
    }
    /// Number of sections
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return presenter.number_ofSections()
    }
    
    /// Message for item
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return presenter.messageForItem(at: indexPath, in: messagesCollectionView)
    }

    ///  Configure media message image view
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        presenter.configurMediaMessageImageView(imageView, for: message, at: indexPath, in: messagesCollectionView)
    }
    /// Chat back ground color
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let sender = message.sender
        let recivedMessegeColor = UIColor(named: "RecivedMessageColor")!
        if sender.senderId == selfSender?.senderId {
            return .secondarySystemBackground
        }
        return recivedMessegeColor
    }
}
