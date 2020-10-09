//
//  Receita.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import Foundation
class Receita: TransacaoModel {
    var recebido: Bool = false
    let transacaoType: TransacaoType = .receita
    
    override init(uid: String, dictionary: [String: Any]) {
        super.init(uid: uid, dictionary: dictionary)
        recebido = super.status
    }
}
