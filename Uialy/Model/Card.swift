//
//  Card.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.04.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Card: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let number: String
    let date: String
    let uid: String
    var CVV: String
    var user: User?

}
