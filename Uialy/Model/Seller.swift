//
//  Seller.swift
//  Uialy
//
//  Created by Abat Sagintayev on 30.03.2022.
//

import FirebaseFirestoreSwift

struct Seller: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
}
