//
//  BankService.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.04.2022.
//

import SwiftUI
import Firebase

class BankService: ObservableObject {
    
    func uploadCard(encryption: String,CVV: String, date: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "number": encryption ,
                    "CVV": CVV,
                    "date": date]
           
        Firestore.firestore().collection("bankcard").document()
            .setData(data)
    }
    
    func fetchCards(completion: @escaping([Card]) -> Void){
        Firestore.firestore().collection("bankcard").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            
            let comments = documents.compactMap({
                try? $0.data(as: Card.self)
            })
            completion(comments)
        }
    }
}
