//
//  DespesasTableViewCell.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class TransacoesTableViewCell: UITableViewCell {
    var despesa: Despesa?
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var status: UIButton!
    
    @IBAction func atualizarStatus(_ sender: Any) {
    }
    
    static let reuseIdentifier = "TransacoesTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrapperView.layer.masksToBounds = true
        wrapperView.layer.cornerRadius = 8
    }
    
    func createCell(despesa: Despesa) {
        self.despesa = despesa
       
    }
    
    func configureCell() {
        if let despesa = despesa {
            self.valor.text = despesa.valorString()
            self.descricao.text = despesa.descricao
        }
    }

}
