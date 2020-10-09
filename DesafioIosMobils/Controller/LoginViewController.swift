//
//  LoginViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func goToRegistrar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registro", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "registro") as? RegistroViewController else { fatalError() }
        navigationController?.pushViewController(viewC, animated: true)
    }
   
    @IBOutlet weak var buttonEntrar: UIButton!
    
    @IBAction func login(_ sender: Any) {
        
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        AuthService.shared.logUserIn(email: email, password: password) {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
    
            self.dismiss(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }

    func configure() {
        email.autocorrectionType = .no
        email.keyboardType = .emailAddress
        navigationController?.isNavigationBarHidden = true
        buttonEntrar.layer.cornerRadius = 5
        buttonEntrar.layer.masksToBounds = true
        
        password.isSecureTextEntry = true
    }
}
