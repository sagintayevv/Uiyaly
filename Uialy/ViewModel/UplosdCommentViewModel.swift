//
//  UplosdCommentViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var didUploadComment = false
    let service = CommentService()
    
    func uploadComment(withCaption caption: String){
        service.uploadComment(caption: caption){
            success in
            if success{
                self.didUploadComment = true
            } else{
                
            }
        }
    }
}
