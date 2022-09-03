//
//  ForgotPasswordView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 07.02.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @State var email = ""
    @State var errString: String?
    @State var showAlert = false
    var body: some View {
        NavigationView{
            VStack{
                
                AuthHeaderView(title1: "Құпия сөзді жаңарту")
                VStack{
                    CustomInputField(imageName: "envelope", placeholderText: "E-mail", isSecureField: false, text:$email)
                    
                    Text("Е-mail адресіңізді енгізіңіз")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                Spacer()
                Button{
                    auth.resetPassword(withEmail: self.email){ (result) in
                        switch result{
                        case.failure(let error):
                            self.errString = error.localizedDescription
                        case.success( _):
                            break
                        }
                        self.showAlert = true
                        
                    }
                    
                } label: {
                    Text("Жаңарту")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .alert(isPresented: $showAlert ) {
                    Alert(title: Text("Құпия сөзді жаңарту"),
                          message: Text(self.errString ?? "Поштаңызды тексеріңіз"),
                          dismissButton: .default(Text("Растау")))
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                .padding(.bottom,32)
                
                NavigationLink{
                    LoginView()
                        .navigationBarHidden(true)
                } label: {
                    HStack{
                        Text("Құпия сөзді білесіз бе?")
                            .font(.footnote)
                        
                        Text("Артқа")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                }
                .padding(.bottom,32)
                .foregroundColor(Color(.systemBlue))
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
