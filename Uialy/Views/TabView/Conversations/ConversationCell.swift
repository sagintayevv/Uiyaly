//
//  ConversationCell.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI
import Kingfisher
struct ConversationCell: View {
    
    let user: User
    
    var body: some View {
        VStack{
        HStack{
            
            
            KFImage(URL(string:user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4){
                Text(user.email)
                    .font(.system(size: 14,weight: .semibold))
                }
            Spacer()
            }
            
            Divider()
        }
    }
}
