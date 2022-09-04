//
//  ConversationPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

// MARK: - Conversation Protocol
protocol ConversationView: AnyObject {
    func creatNewConversation(result: SearchResult)
    func reloadTableView()
    func openExistsConversation(modal: ConversationModel)
    func openNewConversation(email: String, name: String, id: String?)
    func stopAnimation()
    func hideAnimation()
}

// MARK: - Presenter
class ConversationPresenter {
    /// about init and delegation
    private weak var view: ConversationView?
    init(view: ConversationView) {
        self.view = view
    }
    // MARK: - Variables
    var conversationArr = [ConversationModel]()
    
    // MARK: -  Fetch converstions
    func fetchAllConversations() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        DatabaseManager.shared.getAllConversations(safeEmail: safeEmail, completion: { [weak self] result in
            switch result {
            case .success(let conversations):
                print("successfully got conversation models")
                guard !conversations.isEmpty else {
                    return
                }
                self?.conversationArr = conversations
                self?.view?.stopAnimation()
                self?.view?.hideAnimation()
                DispatchQueue.main.async {
                    self?.view?.reloadTableView()
                }
            case .failure(let error):
                print("failed to get convos: \(error)")
                self?.view?.stopAnimation()
                self?.view?.hideAnimation()
            }
        })
    }
    // MARK: - Chcek exist conversation
    func check_ifThere_isConversation(email: String, name: String) {
        DatabaseManager.shared.isConversationExists(recipientEmail: email, completion: { [weak self] result in
            switch result {
            case .success(let conversation_id):
                self?.view?.openNewConversation(email: email, name: name, id: conversation_id)
            case .failure(_):
                self?.view?.openNewConversation(email: email, name: name, id: nil)
            }
        })
    }
    // MARK: -  Handel table view
    /// Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversationArr.count
    }
    /// Cell for row at
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        let modal = conversationArr[indexPath.row]
        cell.Name.text = modal.name
        cell.message.text = modal.latestMessage.text
        cell.download_image(model: modal)
        return cell
    }
    /// Did select row at
    func didSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = conversationArr[indexPath.row]
        view?.openExistsConversation(modal: modal)
    }
    /// Check if conversation is exists new conversation
    func isConversationExists(resutl: SearchResult) {
        
        if let targetConversation = conversationArr.first(where: {
            $0.otherUserEmail == DatabaseManager.safeEmail(emailAddress: resutl.email)
        }) {
            view?.openExistsConversation(modal: targetConversation)
        } else {
            view?.creatNewConversation(result: resutl)
        }
    }
    /// Deleting conversation
    func deletingConversation(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        let conversation_id = conversationArr[indexPath.section].id
        DatabaseManager.shared.deletConversation(conversation_id: conversation_id, completion: { [weak self] success in
            
            if success {
//                self?.deletConversation(tableView: tableView, indexPath: indexPath)
                self?.conversationArr.remove(at: indexPath.section)
                let indexSet = NSMutableIndexSet()
                indexSet.add(indexPath.section)
                tableView.deleteSections(indexSet as IndexSet, with: .automatic)
            }
            
        })
        
        tableView.endUpdates()
    }
    /// Delet conversation
    func deletConversation(tableView: UITableView, indexPath: IndexPath) {
//        conversationArr.remove(at: indexPath.section)
//        let indexSet = NSMutableIndexSet()
//        indexSet.add(indexPath.section)
//        tableView.deleteSections(indexSet as IndexSet, with: .automatic)
    }
}
