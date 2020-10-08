//
//  Despesa.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import Foundation
struct Despesa {
    let valor: Double
    let descricao: String
    let data: TimeInterval
    let pago: Bool
    
    func dataString() -> String {
        return data.description
    }
    
    func valorString() -> String {
        return valor.description
    }
}
