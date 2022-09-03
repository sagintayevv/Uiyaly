//
//  UserService.swift
//  Twitter
//
//  Created by Abat Sagintayev on 21.01.2022.
//


import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        Firestore.firestore().collection("users")
            .document (uid)
            .getDocument{snapshot, _ in
                guard let snapshot = snapshot  else {return}
                
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)
            }
    }
    
    func fetchAdmin(withUid uid: String, completion: @escaping(Seller) -> Void){
        Firestore.firestore().collection("admin")
            .document (uid)
            .getDocument{snapshot, _ in
                guard let snapshot = snapshot  else {return}
                
                guard let user = try? snapshot.data(as: Seller.self) else {return}
                completion(user)
            }
    }
}
