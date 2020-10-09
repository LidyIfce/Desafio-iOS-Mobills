//
//  Despesa.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import Foundation
class Despesa: TransacaoModel {
    var pago: Bool = false
    let transacaoType: TransacaoType = .despesa
    
    override init(uid: String, dictionary: [String: Any]) {
        super.init(uid: uid, dictionary: dictionary)
        pago = super.status
    }
}
