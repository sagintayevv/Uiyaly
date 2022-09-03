//
//  ProfilePage.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 27.12.2021.
//

import SwiftUI
import Kingfisher

struct SellerPage: View {
    
    @EnvironmentObject var authviewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical,showsIndicators: false){
                
                VStack{
                    Text("Кабинет продавца")
                        .font(.system(size: 28, weight: .bold))
                    VStack(spacing: 15){
                        if let user = authviewModel.currentAdmin{
                        Text(user.username)
                            .font(.system(size: 16, weight: .bold))
                        Text(user.email)
                            .font(.footnote)
                            
                        }
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                    
                    
                    CustomNavigationLink(title: "Заказы"){
                        
                        Text("")
                            .navigationTitle("Заказы")
                            .foregroundColor(Color(.systemBlue))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("Back").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Загрузить товар"){
                        ProductsUploadView()
                        Text("")
                        
                            .navigationTitle("Загрузить товар")
                            .foregroundColor(Color(.systemBlue))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("Back").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Список товаров"){
                        
                        Text("")
                            .navigationTitle("Список товаров")
                            .navigationBarTitleDisplayMode(.automatic)
                            .foregroundColor(Color(.systemBlue))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("Back").ignoresSafeArea())
                    }
                    
                    
                    Button{
                        authviewModel.signOut()
                    } label: {
                        Text("Выйти")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 340, height: 50)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                            .padding()
                    }
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .padding()
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("Back")
                    .ignoresSafeArea()
            )
        }
    }
}

struct SellerPage_Previews: PreviewProvider {
    static var previews: some View {
        SellerPage()
    }
}
