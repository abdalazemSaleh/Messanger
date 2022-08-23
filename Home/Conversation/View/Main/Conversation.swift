//
//  Conversation.swift
//  Messanger
//
//  Created by Abdalazem Saleh on 2022-08-01.
//

import UIKit
import Lottie

class Conversation: UIViewController {

    // MARK: - Variables
    var presenter: ConversationPresenter!
    var animationView: AnimationView?
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ConversationPresenter(view: self)
        registerTableViewCell()
        setUpDelegateAndDataSource()
        newChatButton()
        presenter.fetchAllConversations()
        setUpAnimationView()
    }
    // MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
    // MARK: - Set up animation view
    func setUpAnimationView() {
        animationView = .init(name: "13044-message")
        animationView?.frame = CGRect(x: (view.width-120)/2,
                                      y: (view.height-120)/2,
                                      width: 120,
                                      height: 120)
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        view.addSubview(animationView!)
        animationView?.play(completion: nil)
    }
    // MARK: - Set up add new chat button
    /// Set up button
    func newChatButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTabButton))
    }
    /// Func did tab button
    @objc func didTabButton() {
        let vc = AddNewConversation()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}
