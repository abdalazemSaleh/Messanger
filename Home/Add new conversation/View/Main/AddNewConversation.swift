//
//  AddNewConversation.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-10.
//

import UIKit

class AddNewConversation: UIViewController {
    
    // MARK: - Variables
    var presenter: AddNewConversationPresenter!
    var delegate: StartNewConversation?
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddNewConversationPresenter(view: self, delegate: delegate!)
        setUpTableViewDelegateAndDataSource()
        registerTableViewCell()
        searchBar()
    }
    // MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
    
}
