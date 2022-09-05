//
//  Chat+MessageCellExtention.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-27.
//

import MessageKit
import Foundation

extension Chat: MessageCellDelegate {
    
    /// Did tap message
    func didTapMessage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        presenter.didTapMessage(indexPath: indexPath)
    }
    
    /// Did tap image
    func didTapImage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        presenter.didTapImage(indexPath: indexPath)
    }
}
