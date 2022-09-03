//
//  MessageViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 07.04.2022.
//

import SwiftUI
import Firebase

struct MessageViewModel {
    
    let message: Message
    
    var currentUid: String { return AuthViewModel.shared.userSession?.uid ?? "" }
    
    var isFromCurrentUser: Bool { return message.fromId == currentUid }
}

