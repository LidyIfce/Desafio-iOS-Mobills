//
//  NovaTransacaoViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import UIKit

class NovaTransacaoViewController: UIViewController, UIActionSheetDelegate {
    
    var amt = 0
    var transacao: TransacaoModel?
    
    var transacaoType: TransacaoType = .receita {
        didSet {
            switch transacaoType {
            case .despesa:
                self.buttonTipoTransacao.layer.backgroundColor = UIColor.red.cgColor
                self.buttonTipoTransacao.setTitle("Despesa", for: .normal)
                self.labelStatus.text = buttonSwitch.isOn ? "Pago" : "Não foi pago"
                self.buttonSalvar.backgroundColor = UIColor.red
            case .receita:
                self.buttonTipoTransacao.layer.backgroundColor = UIColor.systemGreen.cgColor
                self.buttonTipoTransacao.setTitle("Receita", for: .normal)
                self.labelStatus.text = buttonSwitch.isOn ? "Recebido" : "Não foi recebido"
                self.buttonSalvar.backgroundColor = UIColor.systemGreen
            case .todas: break
            }
        }
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var buttonTipoTransacao: UIButton!
    
    @IBAction func alternarTransacao(_ sender: Any) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let despesa = UIAlertAction(title: "Despesa", style: .default, handler: { _ in
            self.transacaoType = .despesa
        })
        let receita = UIAlertAction(title: "Receita", style: .default, handler: { _ in
            self.transacaoType = .receita
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        menu.addAction(despesa)
        menu.addAction(receita)
        menu.addAction(cancelAction)
        
        present(menu, animated: true, completion: nil)
    }
    
    @IBOutlet weak var valor: UITextField!
    
    @IBOutlet weak var descricao: UITextField!
    
    @IBOutlet weak var buttonSwitch: UISwitch!
    
    
    @IBOutlet weak var labelStatus: UILabel!
    
    @IBAction func switchStatus(_ sender: UISwitch) {
        switch transacaoType {
        case .despesa:
            self.labelStatus.text = sender.isOn ? "Pago" : "Não foi pago"
        case .receita:
            self.labelStatus.text = sender.isOn ? "Recebido" : "Não foi recebido"
        case .todas:
            break
        }
    }
    
    
    @IBOutlet weak var buttonSalvar: UIButton!
    
    @IBAction func salvar(_ sender: Any) {
        
        guard let valorStr = valor.text else { return }
        let tipo = self.transacaoType.rawValue
        guard let descricao = descricao.text else { return }
        let status = buttonSwitch.isOn
        let valor = NSString(string: valorStr).doubleValue
        
        
        if let transacao = transacao {
            TransacaoService.shared.updateTransacao(transacao: transacao, valor: valor, descricao: descricao, status: status, transacaoType: tipo) { (error, ref) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                
            }
        } else {
            
            TransacaoService.shared.uploadTransacao(valor: valor, descricao: descricao, status: status, transacaoType: tipo) { (error, ref) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonTipoTransicao()
        configureButtonSalvar()
        configureTextFields()
        configureValoresParaModoEditar()
    }
    
    
    func configureValoresParaModoEditar() {
        if let transacao = transacao {
            self.descricao.text = transacao.descricao
            self.valor.text = transacao.valor.description
            self.buttonSwitch.isOn = transacao.status
            self.transacaoType = transacao.transacaoType
        }
    }
    
    func updateTextFieldValue() -> String? {
        let number = Double(amt/100) + Double(amt % 100) / 100
        return String(number)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func configureTextFields() {
        valor.keyboardType = .numberPad
        valor.delegate = self
        descricao.keyboardType = .default
        valor.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        descricao.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    func configureButtonTipoTransicao() {
        buttonTipoTransacao.layer.backgroundColor = UIColor.systemGreen.cgColor
        buttonTipoTransacao.setTitle("Receita", for: .normal)
        buttonTipoTransacao.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        buttonTipoTransacao.titleLabel?.textAlignment = .center
        buttonTipoTransacao.titleLabel?.textColor = .white
        buttonTipoTransacao.titleLabel?.tintColor = .white
        buttonTipoTransacao.layer.cornerRadius = 5
        buttonTipoTransacao.layer.masksToBounds = true
        
        buttonTipoTransacao.translatesAutoresizingMaskIntoConstraints = false
        buttonTipoTransacao.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonTipoTransacao.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func configureButtonSalvar() {
        buttonSalvar.layer.backgroundColor = UIColor.systemGreen.cgColor
        buttonSalvar.layer.cornerRadius = 5
        buttonSalvar.layer.masksToBounds = true
    }
    
    @objc func tapDone(sender: UITextView) {
        view.endEditing(true)
    }
    
}

extension NovaTransacaoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let digit = Int(string) {
            amt = amt * 10 + digit
            valor.text = updateTextFieldValue()
        }
        
        if string == "" {
            amt = amt / 10
            valor.text = updateTextFieldValue()
        }
        
        return false
    }
}
