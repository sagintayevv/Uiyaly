//
//  SettingsHeaderView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI
import Kingfisher

struct SettingsHeaderView: View {
    
    let user:User
    
    init(user:User){
        self.user = user
    }
    
    var body: some View {
        
            HStack{
                KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.leading)
            VStack(alignment:.leading, spacing: 4){
                Text(user.fullname)
                    .font(.system(size: 18))
                }
                Spacer()
            }
            .frame(height: 80)
            .background(Color.white)
            
           
        
    }
}

