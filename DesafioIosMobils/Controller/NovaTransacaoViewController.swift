//
//  NovaTransacaoViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import UIKit

class NovaTransacaoViewController: UIViewController {

    @IBOutlet weak var buttonTipoTransacao: UIButton!
    @IBAction func alternarTransacao(_ sender: Any) {
    }
    @IBOutlet weak var valor: UITextField!
    @IBAction func descricao(_ sender: Any) {
    }
    @IBOutlet weak var labelStatus: UILabel!
    
    @IBAction func switchStatus(_ sender: Any) {
    }
    
    
    @IBOutlet weak var buttonSalvar: UIButton!
    
    @IBAction func salvar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
