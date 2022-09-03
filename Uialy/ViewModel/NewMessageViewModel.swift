//
//  File.swift
//  Uialy
//
//  Created by Abat Sagintayev on 27.03.2022.
//

import FirebaseFirestoreSwift
import Firebase

class NewMessageViewModel: ObservableObject{
    
    @Published var users = [User]()

    init(){
        fetchUsers()
    }
    
    func fetchUsers(){

        Firestore.firestore().collection("users").getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            self.users = documents.compactMap({try? $0.data(as:User.self)})
                .filter({ $0.id != Auth.auth().currentUser?.uid})

        }
    }
    
   
}

