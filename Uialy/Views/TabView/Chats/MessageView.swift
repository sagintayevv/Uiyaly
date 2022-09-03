//
//  MessageView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct MessageView: View {
    
    let viewModel: MessageViewModel
    @EnvironmentObject var auth: AuthViewModel
    let user: User
    let rsa : RSA? = RSA()
    @State var key: RegistrationView = RegistrationView()
    init(user: User, viewModel: MessageViewModel){
        self.user = user
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        HStack{
            if viewModel.isFromCurrentUser {
                Spacer()
               
                Text(viewModel.message.text)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 100)
                    .font(.system(size: 15))
                    
            }
            else{
                
                Text(repdecryption())
                    .padding(10)
                    .background(Color(.systemGroupedBackground))
                    .font(.system(size: 15))
                    .clipShape(ChatBubble(isFromCurrentUser: false))
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.trailing,80)
                
                Spacer()
                    
            }
        }
    }
    
//    func decryption() -> String {
//
//        var decryption = [UInt8]()
//
//        let items = viewModel.message.text.split(separator: "|")
//
//        let encrypted = items.map({Int($0) ?? 0})
//
//        for j in 0..<encrypted.count {
//
//            decryption.append( UInt8((rsa?.decryption(encrypted: encrypted[j], d:user.d , n: user.n))!))
//
//        }
//
//        return String(data: Data(decryption), encoding: .utf8) ?? ""
//
//    }

    func repdecryption() -> String {

        var decryption = [UInt8]()

        let items = viewModel.message.text.split(separator: "|")

        let encrypted = items.map({Int($0) ?? 0})

        for j in 0..<encrypted.count {

            decryption.append( UInt8((rsa?.decryption(encrypted: encrypted[j], d:key.dkey , n: auth.currentUser!.n))!))

        }
        
        return String(data: Data(decryption), encoding: .utf8) ?? ""
        
        }
    }
