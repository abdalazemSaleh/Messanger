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
        return messages.count
    }
    
    /// Message for item
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
        
    }
    

}
