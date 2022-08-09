//
//  AddNewConversation+Extention.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit

extension AddNewConversation: UITableViewDataSource, UITableViewDelegate {
    
    /// Set up table view delegate and data source
    func setUpTableViewDelegateAndDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    /// Register table view cell
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "AddNewConversationCell", bundle: nil), forCellReuseIdentifier: "AddNewConversationCell")
    }
    /// Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections(in: tableView)
    }
    /// Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    /// Cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.tableViewCellForRow(tableView, cellForRowAt: indexPath)
    }
    /// Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(tableView, didSelectRowAt: indexPath)
    }
    /// View for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerForSection()
    }
    /// Header for section
    func headerForSection() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    /// Height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    /// Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
