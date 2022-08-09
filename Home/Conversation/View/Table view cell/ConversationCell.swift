//
//  ConversationCell.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit

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
    
}
