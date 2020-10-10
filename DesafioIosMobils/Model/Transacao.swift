//
//  Despesa.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import Foundation
enum TransacaoType: String {
    case todas = "todas", receita = "receita", despesa = "despesa"
}
class TransacaoModel {
    let uid: String
    let valor: Double
    let descricao: String
    var timestamp: Date!
    let status: Bool
    let transacaoType: TransacaoType!
    let user: User!
    
    init(uid: String, user: User, valor: Double, descricao: String, status: Bool, timestamp: Date, transacaoType: TransacaoType) {
        self.uid = uid
        self.valor = valor
        self.descricao = descricao
        self.status = status
        self.timestamp = timestamp
        self.transacaoType = transacaoType
        self.user = user
    }
}
