//
//  TransacoesViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class TransacoesViewController: UIViewController {
    var transacao: [TransacaoModel] = []
  
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelPendente: UILabel!
    
    @IBOutlet weak var valorPendente: UILabel!
    @IBOutlet weak var labelRecebido: UILabel!
    @IBOutlet weak var valueRecebido: UILabel!
    

    @IBAction func adicionarNovaTransacao(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NovaTransacao", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "novatransacao") as? NovaTransacaoViewController else { fatalError() }
        viewC.modalPresentationStyle = .fullScreen
        present(viewC, animated: true)
    }
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.setTitle("Despesas", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(selecionarTipoTransacao), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTableView()
        setupButtonTitle()
    }
  
    func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    @objc func selecionarTipoTransacao() {
        
    }
    private func setupButtonTitle() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        navigationItem.titleView = titleButton
    }
}

