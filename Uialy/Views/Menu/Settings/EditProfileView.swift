//
//  EditProfileView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI
import Firebase
import Kingfisher
struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    let user:User
    
    init(user:User){
        self.user = user
    }
    @State private var fullname = ""
    @State private var username = ""
    
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
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
                    
                    Text("Профиль")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                }
                .padding(.bottom,40)
                VStack(alignment: .leading){
                    HStack{
                        
                            KFImage(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                            
                        
                        HStack{
                            Text(user.fullname)
                                .font(.system(size: 16))
                            Text( user.username )
                                .font(.system(size: 16))
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    Divider()
                        .background(Color(.separator))
                    
                    Text("Аты")
                        .font(.system(size: 14))
                        .padding(.top,10)
                    CustomInputField(imageName: "", placeholderText: "", isSecureField: false, text: $username)
                    
                    Text("Тегі")
                        .font(.system(size: 14))
                        .padding(.top,10)
                    CustomInputField(imageName: "", placeholderText: "", isSecureField: false, text: $fullname)
                    
                }.padding()
                    .background(Color.white)
                
                Button{
                    
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    
                    Firestore.firestore().collection("users")
                        .document(uid)
                        .updateData(["fullname": fullname,
                                     "username": username
                                    ]){ error in
                            
                            
                            if error != nil {
                                print("error")
                            }
                            else {
                                print ("success")
                            }
                            
                        }
                }
            label: {
                Text("Жаңарту")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding(.top,50)
                Spacer()
            }.padding(.top,10)
                .padding(.horizontal)
        }
        
    }
}
