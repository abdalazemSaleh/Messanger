//
//  Conversation+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

extension Conversation: ConversationView {
    
    // Start new converastion
    func doSomeThing(result: SearchResult) {
        guard let name = result.name  as? String,
              let email = result.email as? String else {
                  return
              }
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
    
    /// Open conversation
    func openExistsConversation(modal: ConversationModel) {
        let vc = Chat(email: modal.otherUserEmail, id: modal.id)
        vc.title = modal.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
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
        presenter.creatNewConversation(resutl: targetUser)
    }
}

