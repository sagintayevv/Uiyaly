//
//  NewMessageView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 27.03.2022.
//

import SwiftUI
import Kingfisher

struct NewMessageView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var homeModel: NewMessageViewModel = NewMessageViewModel()

    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(homeModel.users){ user in
                    HStack{
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text(user.username)
                            .font(.system(size: 16, weight: .bold))
                        Text(user.email)
                            .font(.footnote)
                        Spacer()
                    }.padding(.horizontal)
                    Divider()
                        .padding(.vertical,8)
                }
            }.navigationTitle("NewMessage")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button{
                            presentationMode.wrappedValue
                                .dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
}

