//
//  BankCardView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 03.02.2022.
//

import SwiftUI
import Firebase
import Kingfisher


struct BankCardView: View {
    
    @State private var uploadCard = false
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var keyRSA: RSA = RSA()
    @EnvironmentObject  var viewModel: AuthViewModel
    @ObservedObject var cardData = BankCardViewModel()
    @State var key: RegistrationView = RegistrationView()

    let user: User
    
    let rsa : RSA? = RSA()
    
    init(user: User){
        self.user = user
    }
    
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(alignment: .leading){
                
                
                HStack{
                    Button {
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("Банк карталары")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        
                        uploadCard.toggle()
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                }
                .padding(.bottom,40)
                
                
                if cardData.card.isEmpty {
                    
                    HStack(spacing:25){
                        
                        
                        VStack(spacing:10){
                            
                            Image(systemName: "creditcard")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding()
                                .padding(.top,35)
                            
                            Text("Сізде карта табылмады!")
                                .font(.system(size: 25, weight: .semibold))
                            
                            Text("Төмендегі батырма арқылы картаңызды тіркеңіз!")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                
                                uploadCard.toggle()
                                
                            } label: {
                                Text("Тіркеу")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 340, height: 50)
                                    .background(Color(.systemBlue))
                                    .clipShape(Capsule())
                                    .padding()
                            }
                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                            
                        }
                        
                        .padding(.bottom)
                        .padding(.top,80)
                    }
                    
                }
                else {
                    
                    
                    VStack(spacing:5){
                        
                        ForEach(cardData.card){ card in
                            
                            if card.uid == AuthViewModel.shared.userSession?.uid {
                                
                        VStack(spacing:10){
                            
                            Text(decryption(value: card.number))
                                .font(.system(size: 18, weight: .semibold, design: .default))
                            Text(decryption(value: card.CVV))
                                .font(.system(size: 18, weight: .semibold, design: .default))
                            Text(decryption(value: card.date))
                                .font(.system(size: 18, weight: .semibold, design: .default))
  
                        }
                        .frame(maxWidth: .infinity , maxHeight: 200)
                        .padding(.bottom,22)
                        .background(
                            Color.white
                                .cornerRadius(25)
                        )
                       
                        .padding(.bottom)
                    }
                    }
                    }
        
                }
                
                Spacer()
                
            }
            .padding(.top,10)
            .padding(.horizontal)
            
            .sheet(isPresented: $uploadCard){
            }
        content:{
            if let user = viewModel.currentUser{
                UploadBankCard(user: user)
            }
        }
        }
    }
    
    func decryption(value: String) -> String {


        var decryption = [UInt8]()

        let items = value.split(separator: "|")

        let encrypted = items.map({Int($0) ?? 0})

        for j in 0..<encrypted.count {

            decryption.append( UInt8((rsa?.decryption(encrypted: encrypted[j], d: key.dkey , n: user.n))!))

        }

        return String(data: Data(decryption), encoding: .utf8) ?? ""
        }
}


