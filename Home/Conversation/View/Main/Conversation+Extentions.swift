//
//  Conversation+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import Foundation

extension Conversation: ConversationView {
    
}

extension Conversation: StartNewConversation {
    func startNewConversation(targetUser: SearchResult) {
        printContent("Evrey thig is good :)")
        print("my target user is : - \(targetUser)")
    }
}
