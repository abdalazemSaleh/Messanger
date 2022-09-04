//
//  PhotoViewer.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-27.
//

import UIKit
import Kingfisher

class PhotoViewer: UIViewController {

    // MARK: - Variables
    let url: URL
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPhoto.kf.setImage(with: url)
        photo.kf.setImage(with: url)
    }
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - IBOutlet
    @IBOutlet var backgroundPhoto: UIImageView!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var cancelButton: UIButton!
    // MARK: - IBAction
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
