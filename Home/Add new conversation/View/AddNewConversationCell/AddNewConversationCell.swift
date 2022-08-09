//
//  AddNewConversationCell.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-02.
//

import UIKit

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

    
}
