//
//  ConversationPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

// MARK: - Conversation Protocol
protocol ConversationView: AnyObject {
    
}

// MARK: - Presenter
class ConversationPresenter {
    /// about init and delegation
    private weak var view: ConversationView?
    init(view: ConversationView) {
        self.view = view
    }
    // MARK: -  Fetch converstions
    
    
    // MARK: -  Handel table view
    /// Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    /// Cell for row at
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        return cell
    }
}
