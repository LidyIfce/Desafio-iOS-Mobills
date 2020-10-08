//
//  User.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import Foundation
class User {
    let id: UUID
    let nome: String
    let email: String
    let password: String
    
    init(id: UUID = UUID(), nome: String, email: String, password: String) {
        self.id = id
        self.nome = nome
        self.email = email
        self.password = password
    }
}
