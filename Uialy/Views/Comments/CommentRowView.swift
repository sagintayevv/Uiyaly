//
//  CommentRowView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import SwiftUI
import Kingfisher
struct CommentRowView: View {
    let comment: Comment

    
    var body: some View {
        VStack(alignment: .leading){
            if let user = comment.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack{
                            Text(user.fullname)
                            Text(user.username)
                        }
                        
                        Text(comment.caption)
                            .font(.caption)
                    }
                    Spacer()
                }
            }
        }
    }
    
}
