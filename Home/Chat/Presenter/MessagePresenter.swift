//
//  MessagePresenter.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-08.
//

import Foundation

// MARK: - Chat view
protocol chatView: AnyObject {
    
}

// MARK: - Messanger presenter
class ChatPresenter {
    // about init and delegation
    private weak var view: chatView?
    init(view: chatView) {
        self.view = view
    }
    // Variables
    
    // code
    
}
