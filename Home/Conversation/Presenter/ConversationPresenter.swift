//
//  ConversationPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

// MARK: - Conversation Protocol
protocol ConversationView: AnyObject {
    func doSomeThing(result: SearchResult)
    func reloadTableView()
    func openExistsConversation(modal: ConversationModel)
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
    /// Creat new conversation
    func creatNewConversation(resutl: SearchResult) {
        view?.doSomeThing(result: resutl)
    }
}
