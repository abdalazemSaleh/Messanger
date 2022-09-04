//
//  Conversation+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

extension Conversation: ConversationView {
    
    /// open exists conversation
    func openExistsConversation(modal: ConversationModel) {
        let vc = Chat(email: modal.otherUserEmail, id: modal.id)
        vc.isNewConversatoin = false
        vc.title = modal.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    // Start new converastion
    func creatNewConversation(result: SearchResult) {
        let name = result.name
        let email = DatabaseManager.safeEmail(emailAddress: result.email)
        /// Check if conversation is exists before
        /// if yes reuse conversation
        /// else creat new conversation
        presenter.check_ifThere_isConversation(email: email, name: name)
    }
    /// open new conversation
    func openNewConversation(email: String, name: String, id: String?) {
        let vc = Chat(email: email, id: nil)
        vc.isNewConversatoin = true
        vc.title = name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
    
    /// Reload table view
    func reloadTableView() {
        tableView.reloadData()
    }
            
    /// Stop animation
    func stopAnimation() {
        animationView?.stop()
    }
    
    /// Hide animation
    func hideAnimation() {
        animationView?.isHidden = true
    }
}

extension Conversation: StartNewConversation {
    func startNewConversation(targetUser: SearchResult) {
        presenter.isConversationExists(resutl: targetUser)
    }
}

