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
    var tipo: TransacaoType = .todas
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.valor = dictionary["valor"] as? Double ?? 0.0
        self.descricao = dictionary["descricao"] as? String ?? ""
        self.status = dictionary["status"] as? Bool ?? false
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
