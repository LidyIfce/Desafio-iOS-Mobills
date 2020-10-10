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
    @IBOutlet weak var buttonEntrar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func configureView() {
        navigationController?.isNavigationBarHidden = true
        
        email.autocorrectionType = .no
        email.keyboardType = .emailAddress
        email.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
       
        buttonEntrar.layer.cornerRadius = 5
        buttonEntrar.layer.masksToBounds = true
        
        password.isSecureTextEntry = true
        password.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
    }

    @objc func tapDone() {
        view.endEditing(true)
    }
    
    @IBAction func goToRegistrar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registro", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "registro") as? RegistroViewController else { fatalError() }
        navigationController?.pushViewController(viewC, animated: true)
    }
    
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

}
