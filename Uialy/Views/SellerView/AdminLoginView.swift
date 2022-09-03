//
//  AdminLoginView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 30.03.2022.
//


import SwiftUI

struct AdminLoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                AuthHeaderView(title1: "Қош келдіңіз!")
                
                VStack(spacing: 40){
                    CustomInputField(imageName: "envelope", placeholderText: "E-mail",isSecureField: false, text: $email)
                    CustomInputField(imageName: "lock", placeholderText: "Құпия сөз",isSecureField: true,text: $password)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                
                
                HStack{
                    Spacer()
                    NavigationLink {
                        ForgotPasswordView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    } label: {
                        Text("Құпия сөзіңізді ұмыттаңыз ба?")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                            .padding(.top)
                            .padding(.trailing, 24)
                    }
                }
                
                Button{
                   viewModel.adminlogin(withEmail: email, password: password)
                } label: {
                    Text("Кіру")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
                Spacer()
                
                    
                VStack{
                    NavigationLink{
                        AdminRegistrationView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack{
                            Text("Тіркелмегенсіз бе?")
                                .font(.footnote)
                            
                            Text("Жаңа аккаунт")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        
                    }
                    
                    .foregroundColor(Color(.systemBlue))
                    
                    NavigationLink{
                        LoginView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack{
                            Text("Сатып алушы?")
                                .font(.footnote)
                            Text("Кіру")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        
                    }
                    .padding(.bottom,32)
                    .foregroundColor(Color(.systemBlue))
                }
                
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct AdminLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
