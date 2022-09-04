//
//  DeletConversation.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-28.
//

import Foundation
 
#warning("Refactoing")
extension DatabaseManager {
    /// Deleting conversation
    func deletConversation(conversation_id: String, completion: @escaping (Bool) -> Void) {
        let safeEmail = Constant.shared.getUserSafeEmail()
        print(safeEmail)
        print("Deleting conversation id: \(conversation_id)")
        
        /// 1-Get all conversations
        /// 2-Delet target conversation
        /// 3- Refetch conversations
        let refrance = database.child("\(safeEmail)/conversations")
        refrance.observeSingleEvent(of: .value, with: { snapshot in
            if var conversations = snapshot.value as? [[String: Any]] {
                var positionToRemove = 0
                for conversatoin in conversations {
                    if let id = conversatoin["id"] as? String,
                       id == conversation_id {
                        print("found conversation to delete")
                        break
                    }
                    positionToRemove += 1
                }
                
                conversations.remove(at: positionToRemove)

                refrance.setValue(conversations, withCompletionBlock: { error, _  in
                    guard error == nil else {
                        completion(false)
                        print("faield to write new conversatino array")
                        return
                    }
                    print("deleted conversaiton")
                    completion(true)
                })

            }
        })
        
    }
    
    
}
