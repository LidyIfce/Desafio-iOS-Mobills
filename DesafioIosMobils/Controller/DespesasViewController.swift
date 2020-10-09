//
//  DespesasViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class DespesasViewController: UIViewController {
    var despesas: [Despesa] = []

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.allowsSelection = false
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.allowsSelection = true
    }
    func configureTableView() {
        tableView.tableFooterView = UIView()
    }
}

