//
//  Comment.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable,Decodable{
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var user: User?
}
