//
//  TransacaoService.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import Firebase
struct TransacaoService {
    static let shared = TransacaoService()
    
    func uploadTransacao(valor: Double, descricao: String, status: Bool, transacaoType: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "valor": valor, "descricao": descricao, "status": status] as [String : Any]
        Database.database().reference().child(transacaoType).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}
