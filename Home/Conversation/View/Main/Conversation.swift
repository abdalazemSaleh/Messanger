//
//  Conversation.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

class Conversation: UIViewController {

    // MARK: - Variables
    var presenter: ConversationPresenter!
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ConversationPresenter(view: self)
        registerTableViewCell()
        setUpDelegateAndDataSource()
        newChatButton()
        presenter.fetchAllConversations()
    }
    
    // MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
    // MARK: - Set up add new chat button
    /// Set up button
    func newChatButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTabButton))
    }
    /// Func did tab button
    @objc func didTabButton() {
        let vc = AddNewConversation()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}
