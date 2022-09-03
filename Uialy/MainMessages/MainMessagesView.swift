//
//  MainMessagesView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 27.03.2022.
//

import SwiftUI
import Kingfisher
struct MainMessagesView: View {
    
    @EnvironmentObject var newMessage: NewMessageViewModel
    @State var shouldShowMessageScreen = false
    
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    
                    Image(systemName: "person")
                        .font(.system(size: 34))
                    VStack{
                        Text("Username")
                                .font(.system(size: 24,weight: .bold))
                        Text("online")
                                .font(.system(size: 24,weight: .bold))
                                .foregroundColor(Color(.lightGray))
                    }
                
                    Spacer()
                    Button{
                        
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                ScrollView{
                    ForEach(0..<10,id: \.self){ num in
                        VStack{
                            HStack(spacing:16){
                                Image(systemName: "person")
                                    .font(.system(size: 32))
                                
                                VStack(alignment: .leading){
                                    Text("Message Row")
                                    Text("Message sent to user")
                                }
                                Spacer()
                                
                                Text("22d")
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            Divider()
                        }.padding(.horizontal)
                        
                    }.padding(.bottom,50)
                }
                
               
            }
            .overlay(
                Button{
                    shouldShowMessageScreen.toggle()
            } label: {
                HStack{
                    Spacer()
                    Text("New Messages")
                        Spacer()
                }.foregroundColor(.white)
                    .padding(.vertical)
                    .background(Color.blue)
                    .cornerRadius(32)
                    .padding(.horizontal)
                
            }, alignment: .bottom)
            
            .navigationBarHidden(true)
            
            //.navigationTitle("Main Messages")
        }
        .sheet(isPresented: $shouldShowMessageScreen){
        }
    content:{
            NewMessageView()
    }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
