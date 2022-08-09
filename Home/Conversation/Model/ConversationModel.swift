//
//  ConversationModel.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import Foundation

/// Conversation model
struct ConversationModel {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}
/// Latest message
struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
