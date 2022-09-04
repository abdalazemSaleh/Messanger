//
//  Chat+PickerExtention.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-26.
//

import UIKit


extension Chat: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /// image picker control did cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    /// image picker control did finish picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        /// Variables
        let messegeId = creatMessageId()
        guard let conversationId = conversationId,
        let reciverName = self.title,
        let sender = selfSender else {
            return
        }
        /// Check if media is image or video
        if let image = info[.editedImage] as? UIImage, let imageData = image.pngData() {
            let fileName = "photo_message_" + creatMessageId().replacingOccurrences(of: " ", with: "-") + ".png"
            /// Upload image & Send photo message
            presenter.uploadPhotoMessege(fileName: fileName, messageId: messegeId, imageData: imageData, conversationId: conversationId, reciverEmail: reciverEmail, reciverName: reciverName, sender: sender)
        }
        else if let videoUrl = info[.mediaURL] as? URL {
            let fileName = "photo_message_" + creatMessageId().replacingOccurrences(of: " ", with: "-") + ".mov"
            /// Upload video & send video message
            presenter.uploadViedoMessege(fileName: fileName, messageId: messegeId, videoURL: videoUrl, conversationId: conversationId, reciverEmail: reciverEmail, reciverName: reciverName, sender: sender)
        }

    }
    
}
