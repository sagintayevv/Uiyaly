//
//  ChatModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 25.02.2022.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ChatModel: Codable,Identifiable,Hashable {
    
    @DocumentID var id : String?
    let msg : String
    let user : String
    //var timeStamp: Date
    
    
    enum CodingKeys: String,CodingKey {
        case id
        case msg
        case user
      //  case timeStamp
    }
}
