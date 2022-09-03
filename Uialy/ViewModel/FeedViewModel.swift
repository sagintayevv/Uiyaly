//
//  FeedViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import Foundation

class FeedViewModel: ObservableObject{
    @Published var comments = [Comment]()
    
    let service = CommentService()
    let userService = UserService()
    
    init(){
        fetchComments()
    }
    
    func fetchComments(){
        service.fetchComments { comments in
            self.comments = comments
            
            for i in 0 ..< comments.count{
                let uid = comments[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    
                    self.comments[i].user = user
                    
                }
            }
        }
    }
}
