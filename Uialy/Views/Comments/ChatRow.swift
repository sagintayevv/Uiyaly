//
//  ChatRow.swift
//  Uialy
//
//  Created by Abat Sagintayev on 25.02.2022.
//

import SwiftUI

struct ChatRow: View {
    var chatData : ChatModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        HStack(spacing: 15){
            
            if chatData.user == authViewModel.currentUser?.email{ Spacer(minLength: 0)}
            
            VStack(alignment: chatData.user == authViewModel.currentUser?.email ? .trailing : .leading, spacing: 0.5) {
                Text(chatData.msg)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color(chatData.user == authViewModel.currentUser?.email ? .systemBlue : .systemGreen))
                    .cornerRadius(3)
                
                //                Text(chatData.timeStamp,style: .time)
                //                    .font(.caption)
                //                    .foregroundColor(.gray)
                //                    .padding(chatData.user == user ? .leading : .trailing , 10)
            }
            
            if chatData.user != authViewModel.currentUser?.email{ Spacer(minLength: 0)}
            
        }
        .id(chatData.id)
        
    }
}



