//
//  UserApi.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//
import Firebase
import Foundation

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback? ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registrarUsuario (nome: String, email: String, password: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = ["nome": nome, "email": email, "password": password]
            let ref = Database.database().reference().child("users").child(uid)
            
            ref.updateChildValues(values, withCompletionBlock: completion)
        }
    }
    
}
