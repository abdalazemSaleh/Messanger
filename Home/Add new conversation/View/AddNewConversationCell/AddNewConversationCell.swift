//
//  AddNewConversationCell.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit
import Kingfisher

class AddNewConversationCell: UITableViewCell {
    
    @IBOutlet var user_image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 16
        view.addShadowToView()
        user_image.layer.cornerRadius = user_image.frame.width / 2
        user_image.clipsToBounds = true
    }
    
    
    // MARK: - Download image
    func download_image(model: SearchResult) {
        let path = "\(model.email)_profile_picture.png"
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
