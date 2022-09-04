//
//  ConversationCell.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit
import Kingfisher

class ConversationCell: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var user_image: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        user_image.layer.cornerRadius = user_image.frame.size.width / 2
        user_image.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.addShadowToView()
    }
    
    // MARK: - Download image
    func download_image(model: ConversationModel) {
        let path = "\(model.otherUserEmail)_profile_picture.png"
        StorageManager.shared.downloadPhoto(fileName: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                let stringUrl = URL(string: url)
                self?.user_image.kf.indicatorType = .activity
                self?.user_image.kf.setImage(with: stringUrl)
            case .failure(let error):
                print("\(error)")
            }
        })
    }

}
