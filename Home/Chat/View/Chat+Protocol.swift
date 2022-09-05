//
//  Chat+Protocol.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-09-05.
//

import Foundation
import CoreLocation

extension Chat: returnCoordinates {
    func returnCoordinates(coordinates: CLLocationCoordinate2D) {
        /// Variables
        let messegeId = creatMessageId()
        guard let conversationId = conversationId,
        let reciverName = self.title,
        let sender = selfSender else {
            return
        }
        /// Send Location
        presenter.sendLocation(conversationId: conversationId, messageId: messegeId, reciverEmail: reciverEmail, reciverName: reciverName, sender: sender, coordinates: coordinates)
    }
}
