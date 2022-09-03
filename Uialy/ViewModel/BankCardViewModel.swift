//
//  BankCardViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.04.2022.
//

import Foundation
import Firebase

class BankCardViewModel: ObservableObject{
    @Published var card = [Card]()
    
    let service = BankService()
    let userService = UserService()
    
    init(){
        fetchCards()
    }
    
    func fetchCards(){
        
        service.fetchCards { card in
            self.card = card
            
            for i in 0 ..< card.count{
                
                let uid = AuthViewModel.shared.userSession?.uid
                 
                
                if uid == card[i].uid{
                    
                    self.userService.fetchUser(withUid: uid ?? "") { user in
                        
                        self.card[i].user = user
                        
                    }
                }
                
            }
        }
    }
}
