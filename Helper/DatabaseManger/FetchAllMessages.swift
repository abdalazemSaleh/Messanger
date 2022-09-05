//
//  FetchAllMessages.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-14.
//

import Foundation
import UIKit
import MessageKit
import CoreLocation

#warning("Some refactoring in here")
extension DatabaseManager {
    func fetchAllMessagesForConversation(id: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        database.child("\(id)/messages").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            let messages: [Message] = value.compactMap({ dictionary in
                guard let name = dictionary["name"] as? String,
//                    let isRead = dictionary["is_read"] as? Bool,
                    let messageID = dictionary["id"] as? String,
                    let content = dictionary["content"] as? String,
                    let senderEmail = dictionary["sender_email"] as? String,
                    let type = dictionary["type"] as? String,
                    let dateString = dictionary["date"] as? String,
                    let date = UIViewController.dateFormatter.date(from: dateString)else {
                        return nil
                }
                var kind: MessageKind?
                if type == "photo" {
                    guard let placholder = UIImage(systemName: "photo"),
                    let imageUrl = URL(string: content) else {
                        return nil
                    }
                    let media = Media(url: imageUrl,
                                      image: nil,
                                      placeholderImage: placholder,
                                      size: CGSize(width: 240, height: 300))
                    kind = .photo(media)
                }
                else if type == "video" {
                    guard let placholder = UIImage(systemName: "photo"),
                    let videoUrl = URL(string: content) else {
                        return nil
                    }
                    let media = Media(url: videoUrl,
                                      image: nil,
                                      placeholderImage: placholder,
                                      size: CGSize(width: 240, height: 300))
                    kind = .video(media)
                } else if type == "location" {
                    
                    let locationCompnents = content.components(separatedBy: ",")
                    guard let longitude = Double(locationCompnents[0]), let latitude = Double(locationCompnents[1]) else {
                        return nil
                    }
                    let location = Location(location: CLLocation(latitude: latitude, longitude: longitude),
                                            size: CGSize(width: 240, height: 300))
                    
                    kind = .location(location)
                } else {
                    kind = .text(content)
                }
                
                guard let finalKind = kind else {
                    return nil
                }
                
                let sender = sender(senderId: senderEmail,
                                    displayName: name,
                                    photoUrl: "")
                return Message(sender: sender,
                               messageId: messageID,
                               sentDate: date,
                               kind: finalKind)
            })
            completion(.success(messages))
            
        })
    }
}
