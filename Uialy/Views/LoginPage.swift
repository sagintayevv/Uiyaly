//
//  LoginPage.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 20.12.2021.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    
    var body: some View {
        VStack{
            VStack{
                Text("Uialy")
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        ZStack{
                            LinearGradient(colors: [.white,.blue], startPoint: .top, endPoint: .bottom)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(.trailing)
                                .offset(x:60,y:-90)
                                .ignoresSafeArea()
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3),lineWidth:3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 3)
                                .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.bottomTrailing)
                                .padding(30)
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3),lineWidth:3)
                                .frame(width: 20, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.topLeading)
                                .padding(.leading,-20)
                        }
                    )
                
            }
            .frame(height: getRect().height / 4)
            //Login Page Form
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    
                    Text(loginData.registerUser ? "Регистрация" : "Вход")
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
                    //Custom
                    CustomTextField(icon: "envelope", title: "Email", hint: "sagintayev.abat@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,30)
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,10)
                    
                    if loginData.registerUser {
                        CustomTextField(icon: "lock", title: "Re-password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterpasword)
                            .padding(.top,10)
                    }
                    //Forgot
                    
                    Button{
                        loginData.ForgotPassword()
                    }
                label:{
                    Text("Забыли пароль?")
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(.blue)
                    
                    
                }
                .padding(.top,8)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
                    //LoginButton
                    Button{
                        if loginData.registerUser{
                            loginData.Register()
                        }
                        else{
                            loginData.Login()
                        }
                    }
                label:{
                    Text("Вход")
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .padding(.vertical,20)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                    
                    
                }
                .padding(.top,8)
                .padding(.horizontal)
                    //Register User Button
                    
                    Button{
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    }
                label:{
                    Text(loginData.registerUser ? "Войти" : "Создать аккаунт")
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(.blue)
                }
                .padding(.top,8)
                    
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.white)
            .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        
        //Clearing data when
        
        .onChange(of: loginData.registerUser){newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterpasword = false
            
        }
    }
    
    
    @ViewBuilder
    func CustomTextField(icon: String,title:String,hint:String,value: Binding<String>,showPassword:Binding<Bool>)-> some View{
        VStack(alignment: .leading, spacing: 12){
            
            Label{
                Text(title)
                    .font(.system(size: 14))
            }
        icon:{
            Image(systemName: icon)
        }
        .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint,text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint,text: value)
                    .padding(.top,2)
            }
            Divider()
                .background(Color.black.opacity(0.2))
        } .overlay(
            
            Group{
                if title.contains("Password"){
                    Button(action: {showPassword.wrappedValue.toggle()}, label: {
                        Text(showPassword.wrappedValue ?  "Hide" : "Show")
                            .font(.system(size: 13, weight: .bold, design: .default))
                            .foregroundColor(.blue)
                    })
                }
            }
            ,alignment: .trailing
        )
    }
}
