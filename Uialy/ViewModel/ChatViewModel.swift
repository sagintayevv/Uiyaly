//
//  ChatViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI
import Firebase



class ChatViewModel: ObservableObject {

    @Published var messages = [Message]()
    @Published var messageToSetVisible: String?
    let user: User?
    
    init(user: User?){
        self.user = user
        fetchMessages()
//        getAllproducts()
    }
    
//    func fetchMessages(){
//        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
//        guard let chatPartnerId = user.id else {return}
//
//
//        let query = Firestore.firestore().collection("Messages").document(currentUid).collection(chatPartnerId).order(by: "timeStamp",descending: false)
//
//        query.addSnapshotListener { snapshot, _ in
//            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else {return}
//
//            var messages = changes.compactMap{try? $0.document.data(as: Message.self)}
//
//            for( index, message ) in messages.enumerated() where message.fromId != currentUid {
//                messages[index].user = self.user
//
//            self.messages.append(contentsOf: messages)
//
//            }
//        }
//    }
    
     func fetchMessages() {
            guard let fromId = AuthViewModel.shared.userSession?.uid else { return }
            guard let toId = user?.id else { return }
        
        Firestore.firestore()
             .collection("messages")
                         .document(fromId)
                         .collection(toId)
                         .order(by: "timestamp")
                         .addSnapshotListener { querySnapshot, _ in
                             

                             querySnapshot?.documentChanges.forEach({ change in
                                 if change.type == .added {
                                     let data = change.document.data()
                                     
                                     self.messages.append(.init(documentId: change.document.documentID, data: data))
                                     
                                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                         self.messageToSetVisible = self.messages.last?.id
                                         
                                          
                                     }
                                 }
                             })
                         }
                }
        
    func sendMessage(_ messageText: String) {
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        guard let toId = user?.id else {return}
        
        let currentUserRef = Firestore.firestore().collection("messages").document(fromId).collection(toId).document()
        
        let chatPartnerRef = Firestore.firestore().collection("messages").document(toId).collection(fromId)
        
        
        let  messageID = currentUserRef.documentID
        
        let data = ["fromId": fromId,
                    "toId": toId,
                    "text": messageText,
                    "timestamp": Timestamp()] as [String : Any]
        
        
        currentUserRef.setData(data)
        chatPartnerRef.document(messageID).setData(data)
    }

}
