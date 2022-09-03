//
//  User.swift
//
//
//  Created by Abat Sagintayev on 21.01.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    let n: Int
    let e: Int
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }

}


