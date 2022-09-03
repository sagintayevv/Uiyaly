//
//  SideMenuView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 12.02.2022.
//

import SwiftUI
import Kingfisher


struct SideMenuView: View {
    
    @EnvironmentObject var authviewModel: AuthViewModel
    @Binding var showMenu: Bool

    let user: User
    
    init(user: User, showMenu: Binding<Bool>){
        self.user = user
        self._showMenu = showMenu
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
    
                VStack(alignment: .leading,spacing: 15){
                    
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                   
                    VStack(alignment: .leading,spacing: 10){
                            
                            Text(user.fullname)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        
                            Text(user.email)
                                .font(.footnote)
                        
                    }
                }
                .padding(.top)
                .padding(.bottom,50)
            
            Divider()
            HStack{
                Image(systemName: "person.circle")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                NavigationLink("Профиль"){
                    if let user = authviewModel.currentUser{
                    EditProfileView(user: user)
                        .navigationTitle("")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationBarHidden(true)
                    }
                }
                .foregroundColor(.black)
                
            }.frame(height: 50)
            
            HStack{
                Image(systemName: "creditcard")
                    .font(.system(size: 22))
                    .foregroundColor(.blue)
                NavigationLink("Банк карталары"){
                    if let user = authviewModel.currentUser{
                        BankCardView(user: user)
                            .navigationBarTitle("")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .navigationBarHidden(true)
                    }
                    
                }.foregroundColor(.black)
                
            }.frame(height: 50)
            
            HStack{
                Image(systemName: "gear")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                NavigationLink("Баптаулар"){
                    if let user = authviewModel.currentUser{
                        SettingsView(user: user)
                            .navigationBarTitle("")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .navigationBarHidden(true)
                    }
                }
                .foregroundColor(.black)
            }.frame(height: 50)
            
            
            Spacer()
            Divider()
            Button{
                authviewModel.signOut()
            } label: {
                HStack{
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.blue)
                        .font(.system(size: 21))
                    Text("Шығу")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(.systemBlue))
                    
                }
                
            }
            .padding(.top)
            .padding(.bottom)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
        }
        .padding(.horizontal)
        .frame(width: getRect().width)
        
    }
}


@ViewBuilder
func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)-> some View{
    NavigationLink{
        content()
        
    }label: {
        HStack{
            Text(title)
                .font(.system(size: 17, weight: .semibold))
            Spacer()
            
            Image(systemName: "chevron.right")
            
        }
        .foregroundColor(.black)
        .padding(12)
        .background(
            Color.white
                .cornerRadius(12)
        )
        .padding(.horizontal)
        .padding(.top,10)
    }
}

