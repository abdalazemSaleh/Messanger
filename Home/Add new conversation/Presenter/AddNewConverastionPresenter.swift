//
//  AddNewConverastionPresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit

// MARK: - Protocol
/// Add new conversation view
protocol AddNewConversationrView : AnyObject {
    func reloadTableView()
    func goToConverastionScreen()
}
/// Start new conversation
/// Used in Conversation View controller
protocol StartNewConversation {
    func startNewConversation(targetUser: SearchResult)
}

// MARK: - Presenter
class AddNewConversationPresenter {
    // about init and delegation
    private weak var view: AddNewConversationrView?
    init(view: AddNewConversationrView, delegate: StartNewConversation) {
        self.view = view
        self.delegate = delegate
    }
    // Variables
    private var users = [[String: String]]()
    private var results = [SearchResult]()
    private var hasFetched = false
    var delegate: StartNewConversation?
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return results.count
    }
    
    // Cell for row at
    func tableViewCellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewConversationCell", for: indexPath) as! AddNewConversationCell
        let model = results[indexPath.row]
        cell.name.text = model.name
        cell.download_image(model: model)
        return cell
    }
    
    // Did select row
    func didSelectRow(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetUser = results[indexPath.row]
        // Handel delegate
        view?.goToConverastionScreen()
        delegate?.startNewConversation(targetUser: targetUser)
    }
    
    // Search bar button clicked
    func searchBarButtonClicked(text: String) {
        results.removeAll()
        searchForUsers(query: text)
    }
    
    // Search for users
    func searchForUsers(query: String) {
        /// Check if array has firebase results
        if hasFetched {
            /// if it does: filter
            filterUsers(with: query)
        }
        else {
            /// Fetch then filter
            fetchAllUsers(query: query)
        }
    }
    
    // Fetch all users
    func fetchAllUsers(query: String) {
        DatabaseManager.shared.fetchAllUsers(completion: { [weak self] result in
            switch result {
            case .success(let users):
                self?.hasFetched = true
                self?.users = users
                self?.filterUsers(with: query)
            case .failure(let error):
                print("Failed to get users: \(error)")
            }
        })
    }
    
    // Filter users
    func filterUsers(with: String) {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String, hasFetched else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        let results: [SearchResult] = users.filter({
            guard let email = $0["email"], email != safeEmail else {
                return false
            }
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            return name.hasPrefix(with.lowercased())
        }).compactMap({
            guard let email = $0["email"],
                let name = $0["name"] else {
                return nil
            }
            return SearchResult(name: name, email: email)
        })
        self.results = results
        view?.reloadTableView()
    }
}
