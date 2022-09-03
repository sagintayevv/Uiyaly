//
//  ChatView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.presentationMode) var presentationMode
    let user: User
    let rsa : RSA? = RSA()

    init(user: User){
        self.user = user
        self.viewModel = ChatViewModel(user: user)
    }
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                }
                Spacer()
                Text("@\(user.fullname)")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: getRect().width / 2)
               Spacer()
                
               
            }.padding(.horizontal)
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                
            
            ScrollViewReader { value in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageView(user: user,viewModel: MessageViewModel(message: message))
                                .id(message.id)
                        }
                    }.padding(.top)
                }
                .onReceive(viewModel.$messageToSetVisible, perform: { id in
                    value.scrollTo(id)
                })
            }
            
            CustomInputView(text: $messageText, action: sendMessage)
                
                .padding(.horizontal)
        }
        .navigationBarHidden(true)
        
        
    }
    
    func sendMessage(){
        
        viewModel.sendMessage(encryption())
        
    }
    
    func encryption() -> String {
        
        
        var asciiArray = [Int]()
        
        for scalar in messageText.unicodeScalars
        {
            let num = Int(scalar.value)
            asciiArray.append(num)
        }
        
        var encryption = [Int]()
        
        for j in 0..<messageText.count{
            
            encryption.append( (rsa?.encryption(text: asciiArray[j] , e: user.e , n: user.n))! )
            
        }
        let formattedArray = (encryption.map{String($0)}).joined(separator: "|")
       
        return formattedArray
        }
    
}

