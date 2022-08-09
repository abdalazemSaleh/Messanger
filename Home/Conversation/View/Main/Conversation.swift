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
    }
    // MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
}
