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
        navigationController?.popViewController(animated: true)
    }
   
    @IBOutlet weak var buttonEntrar: UIButton!
    
    @IBAction func login(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Despesa", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "despesas") as? DespesasViewController else { fatalError() }
        viewC.modalPresentationStyle = .fullScreen
        self.present(viewC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func configure() {
        navigationController?.isNavigationBarHidden = true
        buttonEntrar.layer.cornerRadius = 5
        buttonEntrar.layer.masksToBounds = true
        
        password.isSecureTextEntry = true
    }
}
