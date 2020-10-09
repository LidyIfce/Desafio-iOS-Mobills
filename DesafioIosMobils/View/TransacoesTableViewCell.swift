//
//  DespesasTableViewCell.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class TransacoesTableViewCell: UITableViewCell {
    var transacao: TransacaoModel?
    
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
    
    func createCell(transacao: TransacaoModel) {
        self.transacao = transacao
       
    }
    
    func configureCell() {
        if let transacao = transacao {
            self.valor.text = transacao.valor.description
            self.descricao.text = transacao.descricao
        }
    }

}
