//
//  Message.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    
//    let id: String
//    let fromId: String
//    let toId: String
//    let timestamp: Timestamp
//    let text: String
//    var read: Bool
//    var user: User?
    
    
    struct FirebaseConstants {
        static let fromId = "fromId"
        static let toId = "toId"
        static let text = "text"
    }
    
    var id: String { documentId }

        let documentId: String
        let fromId, toId, text: String
        
    
        init(documentId: String, data: [String: Any]) {
            self.documentId = documentId
            self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
            self.toId = data[FirebaseConstants.toId] as? String ?? ""
            self.text = data[FirebaseConstants.text] as? String ?? ""
        }
}
 
