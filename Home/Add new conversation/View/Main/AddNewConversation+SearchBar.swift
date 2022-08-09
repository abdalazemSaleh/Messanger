//
//  AddNewConversation+SearchBar.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit

extension AddNewConversation: UISearchBarDelegate {
    
    /// Set up search bar
    func searchBar() {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.tableView.frame.size.width,
                                 height: 48)
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    /// Search bar button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        presenter.searchBarButtonClicked(searchBar)
        
    }
    
}
