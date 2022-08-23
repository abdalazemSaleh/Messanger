//
//  AddNewConversation+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import Foundation

extension AddNewConversation: AddNewConversationrView {
    /// go to conversation controller
    func goToConverastionScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    /// Reload table view
    func reloadTableView() {
        tableView.reloadData()
    }
}

