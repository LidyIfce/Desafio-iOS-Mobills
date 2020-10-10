//
//  TransacaoService.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import Firebase
struct TransacaoService {
    let userTransacaoReference = "user-transacao"
    
    static let shared = TransacaoService()
    
    func uploadTransacao(valor: Double, descricao: String, status: Bool, transacaoType: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "valor": valor, "descricao": descricao, "status": status, "transacaoType": transacaoType] as [String : Any]
        
        let ref = Database.database().reference().child("transacoes").childByAutoId()
        
        let userTransicaoRef = Database.database().reference().child(userTransacaoReference)
        ref.updateChildValues(values) { (error, ref) in
            guard let transacaoId = ref.key else { return }
            userTransicaoRef.child(uid).updateChildValues([transacaoId: 1], withCompletionBlock: completion)
        }
    }
    
    func updateTransacao(transacao: TransacaoModel, valor: Double, descricao: String, status: Bool, transacaoType: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
    
        let values = ["uid": transacao.user.id, "timestamp": Int(NSDate().timeIntervalSince1970), "valor": valor, "descricao": descricao, "status": status, "transacaoType": transacaoType] as [String : Any]
        
    
        let ref = Database.database().reference().child("transacoes").child(transacao.uid)
        
        let userTransicaoRef = Database.database().reference().child(userTransacaoReference)
        ref.updateChildValues(values) { (error, ref) in
            guard let transacaoId = ref.key else { return }
            userTransicaoRef.child(transacao.user.id).updateChildValues([transacaoId: 1], withCompletionBlock: completion)
        }
        
    }
    
    func removeTransacao(transacao: TransacaoModel,completion: @escaping(Error?, DatabaseReference) -> Void) {
    
        var ref = Database.database().reference().child("transacoes").child(transacao.uid)
        ref.removeValue()
        ref = Database.database().reference().child(userTransacaoReference).child(transacao.user.id).child(transacao.uid)
        ref.removeValue(completionBlock: completion)
        
    }
    
    func fetchTransacoes(forUser user: User, completion: @escaping([TransacaoModel]) -> Void) {
        var transacoes = [TransacaoModel]()
        Database.database().reference().child(userTransacaoReference).child(user.id).observe(.childAdded) { snapshot in
            let transacaoId = snapshot.key
            
            Database.database().reference().child("transacoes").child(transacaoId).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                let transacaoId = snapshot.key
                guard let uid = dictionary["uid"] as? String else { return }
                let valor = dictionary["valor"] as? Double ?? 0.0
                let descricao = dictionary["descricao"] as? String ?? ""
                let status = dictionary["status"] as? Bool ?? false
                guard let time = dictionary["timestamp"] as? Double else { return }
                let timestamp = Date(timeIntervalSince1970: time)
                guard let tipo = dictionary["transacaoType"] as? String else { return }
                let transacaoType = TransacaoType(rawValue: tipo) ?? .despesa
                UserService.shared.fetchUser(uid: uid) { user in
                    let transacao = TransacaoModel(uid: transacaoId, user: user, valor: valor, descricao: descricao, status: status, timestamp: timestamp, transacaoType: transacaoType)
                    transacoes.append(transacao)
                    completion(transacoes)
                }
            }
        }
    }
}

