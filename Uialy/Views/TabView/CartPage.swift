//
//  CartPage.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 29.12.2021.
//

import SwiftUI
import Firebase
import Kingfisher

struct CartPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State  var showDeleteOption: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State var showMenu: Bool = false
    @Namespace var animation
    @Binding var tab: Tab

    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        HStack{
                            Text("Себет")
                                .font(.system(size: 28, weight: .bold))
                            
                            Spacer()
                            
                            Button{
                                withAnimation{
                                    showDeleteOption.toggle()
                                }
                            } label: {
                                Image("trash")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                    }
                    if sharedData.cartProducts.isEmpty{
                        
                        Group{
                            Image(systemName: "cart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding()
                                .padding(.top,35)
                            
                            Text("Бос")
                                .font(.system(size: 25, weight: .semibold))
                            
                            Text("Тауарлар себетке қосылғаннан кейін пайда болады")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                            
                           
                            Button {
                                
                                tab = .Home
                                
                            } label: {
                                Text("Сатып алуды бастау")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 340, height: 50)
                                    .background(Color(.systemBlue))
                                    .clipShape(Capsule())
                                    .padding()
                            }
                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                        }
                    }
                    else{
                        VStack(spacing:15){
                            
                            ForEach($sharedData.cartProducts){
                                $product in
                                HStack(spacing:0){
                                    
                                    if showDeleteOption{
                                        Button{
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CardView(product:$product)
                                    
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                        .animation(.easeInOut, value: sharedData.cartProducts)
                    }
                    
                }
                .padding()
                
                
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        HStack{
                            
                            Text("Баға")
                                .font(.system(size: 14, weight: .semibold))
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(.systemBlue))
                        }
                        
                        Button{
                            
                            let data = ["Покупатель": authViewModel.currentUser?.email,
                                        "Модель": sharedData.detailProduct?.subtitle,
                                        "Название": sharedData.detailProduct?.title.lowercased(),
                                        "Стоимость": sharedData.getTotalPrice() ]
                            
                            Firestore.firestore().collection("Orders")
                                .document(UUID().uuidString)
                                .setData(data as [String : Any]){ (error) in
                                    
                                    if error != nil {
                                        print("error")
                                    }
                                    else {
                                        print ("success")
                                    }
                                }
                        } label: {
                            Text("Тапсырыс беру")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.vertical,10)
                                .frame(maxWidth:.infinity)
                                .background(.blue)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal,25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
            )
            
        }
        
        
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.cartProducts.firstIndex(where: {
            currentProduct in
            return product.id == currentProduct.id
        }){
            let _ = withAnimation{
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}


struct CardView: View{
    
    @Binding var product: Product
    var body: some View{
        HStack(spacing: 15){
            
            KFImage (URL(string:product.productImage))
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8){
                Text(product.title)
                    .font(.system(size: 14))
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(.systemBlue))
                
                HStack(spacing: 10){
                    Text("Саны: ")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                    Button{
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color(.systemBlue))
                            .cornerRadius(4)
                        
                    }
                    
                    Text("\(product.quantity)")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(.systemBlue))
                    
                    Button{
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(.blue)
                            .cornerRadius(4)
                        
                    }
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth:.infinity,alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
}
