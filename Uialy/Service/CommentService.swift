//
//  CommentService.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import Firebase

struct CommentService {
    
    func uploadComment(caption: String,completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "caption": caption ,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("comments").document()
            .setData(data){ error in
                if error != nil {
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func fetchComments(completion: @escaping([Comment]) -> Void){
        Firestore.firestore().collection("comments").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            
            let comments = documents.compactMap({
                try? $0.data(as: Comment.self)
            })
            completion(comments)
        }
    }
}
