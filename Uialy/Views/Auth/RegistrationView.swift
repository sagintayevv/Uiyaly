//
//  RegistrationView.swift
//  Twitter
//
//  Created by Abat Sagintayev on 20.01.2022.
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @State private var showPassword: Bool = false
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @State var dkey = UserDefaults.standard.integer(forKey: "Key")
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var keyRSA: RSA = RSA()
    @State var showingAlert = false
    

    
    private var requirements: Array<Bool> {
        [
            password.count >= 8,
            password &= "[0-9]",
            password &= ".*[^A-Za-z0-9].*"
        ]
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: ProfilePhotoSelectorView(),isActive: $viewModel.didAuthUser, label: {})
            AuthHeaderView(title1: "Тіркелу")
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope", placeholderText: "E-mail",isSecureField: false, text: $email)
                CustomInputField(imageName: "person", placeholderText: "Аты",isSecureField: false, text: $username)
                CustomInputField(imageName: "person", placeholderText: "Тегі",isSecureField: false, text: $fullname)
                CustomInputField(imageName: "lock", placeholderText: "Құпия сөз",isSecureField: true, text: $password)
//                HStack{
//                    Image(systemName: "lock")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color(.darkGray))
//
//                    if showPassword  {
//                        TextField("placeholderText", text: $password)
//                            .accentColor(.blue)
//
//                    }
//                    else{
//                        SecureField("placeholderText", text: $password)
//                            .accentColor(.blue)
//                    }
//
//                    Button{
//                        self.showPassword.toggle()
//                    } label: {
//                        Image(systemName: "eye")
//                    }
//                }
//                Divider()
//                    .background(Color(.darkGray))
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Құпия сөз :")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14))
                        Spacer()
                    }
                    Group{
                        Text("• Кем дегенде 8 латын әріпінен,сан және символдардан құралуы қажет, *@$&^!#")
                            .foregroundColor(self.requirements[0]&&self.requirements[1]&&self.requirements[2] ? .green : .red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                }
            }
            .padding(.horizontal,32)
            .padding(.top, 44)
            Spacer()
            
            Button{
                
                if self.requirements[0] && self.requirements[1] && self.requirements[2] {
                    
                    let p = keyRSA.publicKey
                    let q = keyRSA.privateKey
                    
                    let n = p  * q
                    
                    let phi = (p  - 1) * (q  - 1)
                    
                    let e = keyRSA.E(phi: phi)
                    
                    let d = keyRSA.D(e: e, phi: phi)
                    
                    UserDefaults.standard.set(d, forKey: "Key")
                    
                    viewModel.register(withEmail: email, password: password, fullname: fullname, username: username, n: n, e: e)
                      
                }
                
                else{
                    showingAlert = true
                }
                
            } label: {
                Text("Тіркелу")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .alert("Қате",isPresented: $showingAlert, actions: {
                
            },message:{
                Text("Қайта көріңіз!")
            })
            Spacer()

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Text("Тіркелгенсіз бе?")
                        .font(.footnote)
                    
                    Text("Кіру")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
            }
            .padding(.bottom,30)
            .foregroundColor(Color(.systemBlue))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

extension String {
    static func &= (lhs: String, rhs: String) -> Bool {
        return lhs.range(of: rhs,options: .regularExpression) != nil
    }
}
