//
//  Despesa.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import Foundation
class Despesa: TransacaoModel {
    var pago: Bool = false
    
    init(uid: String, transacao: TransacaoModel) {
        super.init(uid: uid, valor: transacao.valor, descricao: transacao.descricao, status: transacao.status, timestamp: transacao.timestamp, transacaoType: transacao.transacaoType)
        pago = super.status
    }
}
