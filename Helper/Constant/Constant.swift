//
//  Constant.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit


class Constant {
    
    static let shared = Constant()
    
    func setUpStoryboard(name: String) -> UIStoryboard {
        let storyBoard = UIStoryboard.init(name: name, bundle: Bundle.main)
        return storyBoard
    }
}
