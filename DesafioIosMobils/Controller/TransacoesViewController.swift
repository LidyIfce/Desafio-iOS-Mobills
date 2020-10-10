//
//  TransacoesViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
import Firebase
protocol TransacoesDelegate: class {
    func didRemove(indice: Int)
}

class TransacoesViewController: UIViewController {
    
    var transacoes = [TransacaoModel]() {
        didSet {
            calcValores(transacoes: transacoes)
            tableView.reloadData()
        }
    }
    private var user: User? {
        didSet {
            fetchTransacao()
            calcValores(transacoes: transacoes)
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
            createSpinnerView()
            fetchTransacao()
        }
    }
    let child = SpinnerViewController()
    var activity = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelPendente: UILabel!
    
    @IBOutlet weak var valorPendente: UILabel!
    @IBOutlet weak var labelRecebido: UILabel!
    @IBOutlet weak var valorRecebido: UILabel!
    
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
        fetchUser()
        configureTableView()
        createSpinnerView()
        setupButtonTitle()
        fetchTransacao()
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUser()
        fetchTransacao()
        calcValores(transacoes: transacoes)
    }
    
    func createSpinnerView() {
       
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

      
        
    }

    @IBAction func adicionarNovaTransacao(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NovaTransacao", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "novatransacao") as? NovaTransacaoViewController else { fatalError() }
        viewC.modalPresentationStyle = .fullScreen
        present(viewC, animated: true)
    }
    
    
    @IBAction func sair(_ sender: Any) {
        AuthService.shared.logUserOut()
        exit(0)
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func fetchTransacao() {
        if let user = user {
            TransacaoService.shared.fetchTransacoes(forUser: user) { (transacoes) in
                var receitas = [TransacaoModel]()
                var despesas = [TransacaoModel]()
                for transacao in transacoes {
                    switch transacao.transacaoType {
                    case .despesa:
                        despesas.append(transacao)
                    case .receita:
                        receitas.append(transacao)
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
            
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
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
        
        menu.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
    }
    private func setupButtonTitle() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        navigationItem.titleView = titleButton
    }
    
    func calcValores(transacoes: [TransacaoModel]) {
        var receitasRecebidas: Double = 0
        var receitasPendentes: Double = 0
        var despesasPagas: Double = 0
        var despesasPendentes: Double = 0
        
        for transacao in transacoes {
            if transacao.transacaoType == .receita {
                if transacao.status == true {
                    receitasRecebidas += transacao.valor
                } else {
                    receitasPendentes += transacao.valor
                }
            } else if transacao.transacaoType == .despesa {
                if transacao.status == true {
                    despesasPagas += transacao.valor
                } else {
                    despesasPendentes += transacao.valor
                }
            }
        }
        switch transacaoType {
        case .receita:
            labelPendente.text = "Total pendente"
            valorPendente.text = formatNumber(number: receitasPendentes)
            labelRecebido.text = "Total recebido"
            valorRecebido.text = formatNumber(number: receitasRecebidas)
        case .despesa:
            labelPendente.text = "Total pendente"
            valorPendente.text = formatNumber(number: despesasPendentes)
            labelRecebido.text = "Total pago"
            valorRecebido.text = formatNumber(number: despesasPagas)
        case .todas:
            labelPendente.text = "Saldo atual"
            valorPendente.text = "R$ " + String(receitasRecebidas - despesasPagas)
            labelRecebido.text = "Balanço atual"
            let balanco = (receitasPendentes + receitasRecebidas) - (despesasPagas + despesasPendentes)
            valorRecebido.text = formatNumber(number: balanco)
        }
        
    }
    
    func formatNumber(number: Double) -> String {
        String(format: "R$ %.2f", number)
    }
}

extension TransacoesViewController: TransacoesDelegate {
    func didRemove(indice: Int) {
        transacoes.remove(at: indice)
        tableView.reloadData()
    }
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)
 
    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .label
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
