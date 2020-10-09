//
//  DespesasViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class DespesasViewController: UIViewController {
    var despesas: [Despesa] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelPendente: UILabel!
    
    @IBOutlet weak var valorPendente: UILabel!
    @IBOutlet weak var labelRecebido: UILabel!
    @IBOutlet weak var valueRecebido: UILabel!
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor.blue.cgColor
        button.setTitle("Despesas", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .black
        button.titleLabel?.tintColor = .black
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(selecionarTipoTransacao), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.allowsSelection = false
        setupButtonTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.allowsSelection = true
    }
    func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    @objc func selecionarTipoTransacao() {
        print("ok")
    }
    private func setupButtonTitle() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        navigationItem.titleView = titleButton
    }
}

