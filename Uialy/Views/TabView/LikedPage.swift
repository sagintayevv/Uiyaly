//
//  LikedPage.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 28.12.2021.
//

import SwiftUI
import Kingfisher
struct LikedPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var showDeleteOption: Bool = false
    @Namespace var animation
    @Binding var tab: Tab

    
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    HStack{
                        Text("Таңдамалар")
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
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    if sharedData.likedProducts.isEmpty{
                        
                        Group{
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding()
                                .padding(.top,35)
                            
                            Text("Бос")
                                .font(.system(size: 25, weight: .semibold))
                            
                            Text("Таңдаулыларға өнімдерді қосыңыз және жылдам іздеу үшін тізімдер жасаңыз")
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
                    
                    VStack(spacing:15){
                        
                        ForEach(sharedData.likedProducts){
                            product in
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
                                CardView(product:product)
                                
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    sharedData.detailProduct = product
                                    sharedData.showDetailProduct = true
                                }
                            }
                        }
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
            )
        }
    }
    
    
    @ViewBuilder
    func CardView(product: Product)-> some View{
        
        HStack{
            
            KFImage (URL(string:product.productImage))
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8){
                Text(product.title)
                    .font(.system(size: 14))
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemBlue))
                HStack{
                    Text("\(product.price)т")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button{
                        addToCart(product: product)
                    } label: {
                        Text("\(isAddedToCart(product:product) ? "Себетте" : "Таңдау" )")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 30)
                            .background(Color(.systemBlue))
                            .cornerRadius(5)
                    }
                    
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 0)
                }
            }
        }
        .animation(.easeInOut, value: sharedData.cartProducts)
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth:.infinity,alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    func deleteProduct(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: {
            currentProduct in
            return product.id == currentProduct.id
        }){
            let _ = withAnimation{
                //removing
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
    func isAddedToCart(product: Product)-> Bool{
        
        return sharedData.cartProducts.contains{
            currentproduct in
            return product.id == currentproduct.id
        }
    }
    func addToCart(product: Product){
        if let index = sharedData.cartProducts.firstIndex(where: {
            currentproduct in
            return product.id == currentproduct.id
        }){
            sharedData.cartProducts.remove(at: index)
        }
        else{
            sharedData.cartProducts.append(product)
        }
    }
}

