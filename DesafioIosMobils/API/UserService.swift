//
//  UserService.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//
import Firebase
import Foundation

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: AnyObject] else { return }
           
            let user = User(id: uid, dictionary: dict)
            completion(user)
        }
    }
}
