//
//  AddNewConversation.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

class AddNewConversation: UIViewController {

    // MARK: - Variables
    var presenter: AddNewConversationPresenter!
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddNewConversationPresenter(view: self)
        setUpTableViewDelegateAndDataSource()
        registerTableViewCell()
        searchBar()
    }
    // MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
}
