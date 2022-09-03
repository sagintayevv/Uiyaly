//
//  ChatView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 25.02.2022.
//

import SwiftUI
import Firebase



struct ChatView: View {
    @EnvironmentObject var authviewModel: AuthViewModel
    @ObservedObject var chatData = ChatViewModel()
    @AppStorage("current_user") var user = ""
    
    var body: some View {
        VStack{
            
            HStack{
                Text("uialy.support")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.top,20)
                
                
            }
            .frame(maxWidth:.infinity, maxHeight: 40)
            .padding()
            .background(Color(.systemGray))
            
            
            ScrollViewReader{ reader in
                
                ScrollView{
                    VStack{
                        ForEach(chatData.msgs){ msg in
                            ChatRow(chatData: msg)
                        }
                    }
                }
                .padding()
            }
            
            HStack(spacing:15){
                TextField("Жазу",text: $chatData.txt)
                    .padding(.horizontal)
                    .frame( height: 45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                    .accentColor(Color(.systemBlue))
                
                if chatData.txt != ""{
                    Button(
                        action: {
                            let data = ["user": authviewModel.currentUser?.email,
                                        "msg": chatData.txt]
                            
                            Firestore.firestore().collection("Messages")
                                .document(UUID().uuidString)
                                .setData(data as [String : Any]){ (error) in
                                    
                                    if error != nil {
                                        print("error")
                                    }
                                    else {
                                        print ("success")
                                    }
                                }
                            
                            chatData.txt = ""},
                        
                        label: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Color(.systemBlue))
                                .clipShape(Circle())
                        }
                    )
                }
            }
            .padding(.bottom,10)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
        
    }
}
