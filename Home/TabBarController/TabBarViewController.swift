//
//  TabBarViewController.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-09.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    let layer = CAShapeLayer()
    var layerHeight = CGFloat()
    let bgColor = UIColor.white
    let sColor = UIColor.gray
    let tColor = UIColor.black
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        
    }
    
    func setUpTabBar() {
        // tab bar layer
        let x: CGFloat = 10
        let y: CGFloat = 20
        let width = self.tabBar.bounds.width - x * 2
        let height = self.tabBar.bounds.height + y * 1.5
        layerHeight = height
        layer.fillColor = bgColor.cgColor
        layer.path = UIBezierPath(roundedRect: CGRect(x: x,
                                                      y: self.tabBar.bounds.minY - y,
                                                      width: width,
                                                      height: height),
                                  cornerRadius: height / 2).cgPath
        
        // tab bar shadow
        layer.shadowColor = tColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        
        // add tab bar layer
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        // fix items positioning
        self.tabBar.itemWidth = width / 6
        self.tabBar.itemPositioning = .centered
        self.tabBar.unselectedItemTintColor = sColor
    }
    
}
