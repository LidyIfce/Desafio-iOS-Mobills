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
        
        let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "valor": valor, "descricao": descricao, "status": status, "transacaoType": transacaoType] as [String : Any]
      
        Database.database().reference().child("transacoes").childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTransacao(completion: @escaping([TransacaoModel]) -> Void ) {
        var transacoes = [TransacaoModel]()
        Database.database().reference().child("transacoes").observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let transacaoId = snapshot.key
            let valor = dictionary["valor"] as? Double ?? 0.0
            let descricao = dictionary["descricao"] as? String ?? ""
            let status = dictionary["status"] as? Bool ?? false
            guard let time = dictionary["timestamp"] as? Double else { return }
            let timestamp = Date(timeIntervalSince1970: time)
            guard let tipo = dictionary["transacaoType"] as? String else { return }
            let transacaoType = TransacaoType(rawValue: tipo) ?? .despesa
            
            let transacao = TransacaoModel(uid: transacaoId, valor: valor, descricao: descricao, status: status, timestamp: timestamp, transacaoType: transacaoType)
            transacoes.append(transacao)
            completion(transacoes)
        }
    }
    
    func fetchDespesa(completion: @escaping([Despesa]) -> Void ) {
        
    }
}
