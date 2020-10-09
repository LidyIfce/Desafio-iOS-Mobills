//
//  TransacoesViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class TransacoesViewController: UIViewController {
    
    var transacoes = [TransacaoModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    var transacaoType: TransacaoType = .todas {
        didSet {
            switch transacaoType {
            case .despesa:
                titleButton.setTitle("Despesas", for: .normal)
            case .receita:
                titleButton.setTitle("Receitas", for: .normal)
            case .todas:
                titleButton.setTitle("Transações", for: .normal)
            }
            fetchTransacao()
        }
    }
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
        button.setTitle("Transações", for: .normal)
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
        fetchTransacao()
    }
    
    func fetchTransacao() {
        TransacaoService.shared.fetchTransacao() { (transacoes) in
            var receitas = [Receita]()
            var despesas = [Despesa]()
            for transacao in transacoes {
                switch transacao.transacaoType {
                case .despesa:
                    despesas.append(Despesa(uid: transacao.uid,transacao: transacao))
                case .receita:
                    receitas.append(Receita(uid: transacao.uid, transacao: transacao))
                case .todas:
                    break
                default: break
                }
            }
            
            switch self.transacaoType {
            case .receita:
                self.transacoes = receitas
            case .despesa:
                self.transacoes = despesas
            case .todas:
                self.transacoes = transacoes
            }
           
        }
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
    @objc func selecionarTipoTransacao() {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let transacoes = UIAlertAction(title: "Transações", style: .default, handler: { _ in
            self.transacaoType = .todas
        })
        let despesa = UIAlertAction(title: "Despesa", style: .default, handler: { _ in
            self.transacaoType = .despesa
        })
        let receita = UIAlertAction(title: "Receita", style: .default, handler: { _ in
            self.transacaoType = .receita
        })

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        menu.addAction(transacoes)
        menu.addAction(despesa)
        menu.addAction(receita)
        menu.addAction(cancelAction)

        present(menu, animated: true, completion: nil)
    }
    private func setupButtonTitle() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        navigationItem.titleView = titleButton
    }
}

