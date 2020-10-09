//
//  TransacoesExtension.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
extension TransacoesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransacoesTableViewCell.reuseIdentifier) as? TransacoesTableViewCell else { return UITableViewCell() }
      //  cell.createCell(despesa: despesas[indexPath.row])
       
        return cell
    }
    
    
}
