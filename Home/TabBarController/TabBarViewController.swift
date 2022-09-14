//
//  TabBarViewController.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-09.
//

import UIKit

//class TabBarViewController: UITabBarController {

//    // MARK: - Variables
//    let layer = CAShapeLayer()
//    var layerHeight = CGFloat()
//    let bgColor = UIColor.white
//    let sColor = UIColor.gray
//    let tColor = UIColor.black
//
//    // MARK: - Set up middle button
//    var middleButton: UIButton = {
//        let b = UIButton()
//        let c = UIImage.SymbolConfiguration(pointSize: 15, weight: .heavy, scale: .large)
//        b.setImage(UIImage(systemName: "plus", withConfiguration: c), for: .normal)
//        b.imageView?.tintColor = .white
//        b.backgroundColor = UIColor.blue
//        return b
//    }()
//
//    @IBOutlet var myBar: UITabBar!
//    // MARK: - View did load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpTabBar()
//        addMiddleButton()
//    }
//
//    // MARK: - Button clicked
//    @objc func buttonHandler(sender: UIButton) {
//    }
//
//    // MARK: - Add middle button
//    func addMiddleButton() {
//
//        DispatchQueue.main.async {
//            if let items = self.tabBar.items {
//                items[1].isEnabled = false
//            }
//        }
//
//        // shape, position and size
//        tabBar.addSubview(middleButton)
//        let size = CGFloat(50)
//        let constant: CGFloat = -20 + ( layerHeight / 2 ) - 5
//
//        // set constraints
//        let constraints = [
//            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
//            middleButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: constant),
//            middleButton.heightAnchor.constraint(equalToConstant: size),
//            middleButton.widthAnchor.constraint(equalToConstant: size)
//        ]
//        for constraint in constraints {
//            constraint.isActive = true
//        }
//        middleButton.layer.cornerRadius = size / 2
//
//        // shadow
//        middleButton.layer.shadowColor = tColor.cgColor
//        middleButton.layer.shadowOffset = CGSize(width: 0,
//                                                 height: 8)
//        middleButton.layer.shadowOpacity = 0.75
//        middleButton.layer.shadowRadius = 13
//
//        // other
//        middleButton.layer.masksToBounds = false
//        middleButton.translatesAutoresizingMaskIntoConstraints = false
//
//        // action
//        middleButton.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
//
//    }
//
//    // MARK: - Set up tab bar
//    func setUpTabBar() {
//        // tab bar layer
//        let x: CGFloat = 10
//        let y: CGFloat = 20
//        let width = self.tabBar.bounds.width - x * 2
//        let height = self.tabBar.bounds.height + y * 1.5
//        layerHeight = height
//        layer.fillColor = bgColor.cgColor
//        layer.path = UIBezierPath(roundedRect: CGRect(x: x,
//                                                      y: self.tabBar.bounds.minY - y,
//                                                      width: width,
//                                                      height: height),
//                                  cornerRadius: height / 2).cgPath
//
//        // tab bar shadow
//        layer.shadowColor = tColor.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        layer.shadowRadius = 5.0
//        layer.shadowOpacity = 0.5
//
//        // add tab bar layer
//        self.tabBar.layer.insertSublayer(layer, at: 0)
//
//        // fix items positioning
//        self.tabBar.itemWidth = width / 6
//        self.tabBar.itemPositioning = .centered
//        self.tabBar.unselectedItemTintColor = sColor
//
//        self.tabBar.backgroundColor = .systemBackground
//    }

//}
