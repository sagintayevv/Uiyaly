//
//  UploadBankCard.swift
//  Uialy
//
//  Created by Abat Sagintayev on 12.04.2022.
//

import SwiftUI
import Firebase

struct UploadBankCard: View {
    
    @State private var number = ""
    @State private var date = ""
    @State private var CVV = ""
    @ObservedObject var viewBank: BankService
    @Environment(\.presentationMode) var presentationMode
    @StateObject var keyRSA: RSA = RSA()
    let user: User
    
    let rsa : RSA? = RSA()
    
    init(user: User){
        self.user = user
        self.viewBank = BankService()
    }
    
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        VStack(alignment: .leading){
            
            Group{
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("Картаны тіркеу")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        
                        presentationMode.wrappedValue.dismiss()

                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                }
                .padding(.bottom,40)
                
                Text("Карта нөмірі")
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "Required", isSecureField: false, text: $number)
                
                Text("Жарамды мерзімі")
                    .frame(alignment: .leading)
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "MM/YYYY", isSecureField: false, text: $date)
                
                Text("CVV")
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "CVV", isSecureField: false, text: $CVV)
            }
            
            
            HStack{
            
            Button{
               
                viewBank.uploadCard(encryption: encryption(value: number), CVV: encryption(value: CVV), date: encryption(value: date))
                presentationMode.wrappedValue.dismiss()

            }
        label: {
            Text("Жүктеу")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemBlue))
                .clipShape(Capsule())
            
        }.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
        }
            .frame(maxWidth: .infinity)
            .padding(.top,50)
        
            
            Spacer()
            
        }
        .padding(.top,30)
        .padding(.horizontal)
    }
    }
    
    func encryption(value: String) -> String {
        
        
        var asciiArray = [Int]()
        
        for scalar in value.unicodeScalars
        {
            let num = Int(scalar.value)
            asciiArray.append(num)
        }
        print(asciiArray)
        
        var encryption = [Int]()
        
        for j in 0..<value.count{
            
            encryption.append( (rsa?.encryption(text: asciiArray[j] , e: user.e , n: user.n))! )
            
        }
        let formattedArray = (encryption.map{String($0)}).joined(separator: "|")
       
        return formattedArray
        }
    
    
}

