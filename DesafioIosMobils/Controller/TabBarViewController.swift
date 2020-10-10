//
//  TabBarViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController {
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfigureUI()
    }
    
    func fetchUser() {
        DispatchQueue.main.async {
            guard let id = Auth.auth().currentUser?.uid else { return }
            UserService.shared.fetchUser(uid: id) { user in
                self.user = user
            }
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let viewC = storyboard.instantiateViewController(identifier: "login") as? LoginViewController else { fatalError() }
                let nav = UINavigationController(rootViewController: viewC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            fetchUser()
        }
    }
}
