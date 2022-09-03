//
//  ConversationsView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct ConversationsView: View {
    
    @State private var shownewMessageView = false
    @State private var showChatView = false
    @ObservedObject var viewModel = NewMessageViewModel()
    
    @State var selectedUser: User?
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
           
            if let user = selectedUser {
                NavigationLink(destination: ChatView(user: user),
                               isActive: $showChatView,
                               label: {})
                    
            }
            
            VStack{
                HStack{
                    Text("Uialy.support")
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                   
                }
                .frame(height: 50)
                Divider()
                    .background(.blue)
            ScrollView{

                VStack(alignment:.leading){
                    ForEach(viewModel.users){ user in
                        
                        NavigationLink(destination: ChatView(user: user),
                                       
                                       label: { ConversationCell(user: user)
                                                    .foregroundColor(.black)
                                                    
                        })
                        
                    }
                }
            }.padding(.top, 25)
            }.padding().frame(maxWidth: .infinity)
            
            Button{
                shownewMessageView.toggle()
            } label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
            }   .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $shownewMessageView, content:{ NewMessageView(showChatView: $showChatView, user: $selectedUser)})
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }.frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
