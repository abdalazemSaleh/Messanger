//
//  Chat.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-10.
//

import UIKit
import MessageKit
import SwiftUI

class Chat: MessagesViewController {
    
    // MARK: - Variables
    var presenter: ChatPresenter!
    var isNewConversatoin = false
    var messages = [Message]()
    let reciverEmail: String
    var conversationId: String?
    
    // Self sender
    var selfSender: sender? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        return sender(senderId: safeEmail,
                      displayName: "Me",
                      photoUrl: "")
    }
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        presenter = ChatPresenter(view: self)
        setUpMessageLayoutAndDisplayDelegateAndDatasource()
        setUpInputAccessory()
                
    }
    // MARK: -  Init
    init(email: String, id: String?) {
        self.reciverEmail = email
        self.conversationId = id
        super.init(nibName: nil, bundle: nil)
    }
    /// requird init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            messageInputBar.inputTextView.becomeFirstResponder()
            if let conversationId = conversationId {
                getAllMessages(conversationId: conversationId, shouldScrollToBottom: true)
            }
        }
    
    // TODO: Refactoring -
    
    func getAllMessages(conversationId: String, shouldScrollToBottom: Bool) {
        DatabaseManager.shared.fetchAllMessagesForConversation(id: conversationId, completion: { [weak self] result in
            switch result {
            case .success(let messages):
                print("success in getting messages: \(messages)")
                guard !messages.isEmpty else {
                    print("messages are empty")
                    return
                }
                self?.messages = messages
                
                DispatchQueue.main.async {
                    self?.messagesCollectionView.reloadDataAndKeepOffset()
                    
                    if shouldScrollToBottom {
                        self?.messagesCollectionView.scrollToLastItem()
                    }
                }
                
            case .failure(let error):
                print("failed to get messages: \(error)")
            }
        })
    }
    
    
    
    
}
