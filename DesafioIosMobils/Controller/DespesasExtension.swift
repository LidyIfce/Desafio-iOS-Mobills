//
//  DespesasExtension.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
extension DespesasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DespesasTableViewCell.reuseIdentifier) as? DespesasTableViewCell else { return UITableViewCell() }
      //  cell.createCell(despesa: despesas[indexPath.row])
       
        return cell
    }
    
    
}
