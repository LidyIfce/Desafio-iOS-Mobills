//
//  RegistroViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
import Firebase
class RegistroViewController: UIViewController {

    @IBOutlet weak var nome: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var buttonRegistrar: UIButton!
 
    @IBAction func registrar(_ sender: Any) {
        guard let nome = nome.text else { return }
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        AuthService.shared.registrarUsuario(nome: nome, email: email, password: password) { (error, ref) in
            print("Cadastrado com sucesso!")
            
            let storyboard = UIStoryboard(name: "Despesa", bundle: nil)
            guard let viewC = storyboard.instantiateViewController(identifier: "despesas") as? DespesasViewController else { fatalError() }
            viewC.modalPresentationStyle = .fullScreen
            self.present(viewC, animated: true)
        }
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        navigationController?.isNavigationBarHidden = true
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "login") as? LoginViewController else { fatalError() }
        navigationController?.pushViewController(viewC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    

    func configure() {
        email.autocorrectionType = .no
        nome.autocorrectionType = .no
        email.keyboardType = .emailAddress
     
        buttonRegistrar.layer.cornerRadius = 5
        buttonRegistrar.layer.masksToBounds = true
        
        password.isSecureTextEntry = true
    }

}
