//
//  DespesasTableViewCell.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class DespesasTableViewCell: UITableViewCell {
    var despesa: Despesa?
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var pago: UISwitch!
    @IBOutlet weak var descricao: UILabel!
    
    static let reuseIdentifier = "DespesasTableViewCell"
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
            self.data.text = despesa.dataString()
            self.descricao.text = despesa.descricao
            self.pago.isOn = despesa.pago
        }
    }

}
