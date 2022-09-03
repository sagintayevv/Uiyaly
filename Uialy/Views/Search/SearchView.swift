//
//  SearchView.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 22.12.2021.
//

import SwiftUI
import Kingfisher
struct SearchView: View {
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    @FocusState var startTF : Bool
    var body: some View {
        
        VStack(spacing: 0){
            HStack(spacing: 20){
                
                Button{
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.seacrhText = ""
                    sharedData.fromSearchPage = false
                }label:{
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                HStack(spacing:15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Іздеу",text: $homeData.seacrhText)
                        .accentColor(.blue)
                        .focused($startTF)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    
                }
                .padding(.vertical,8)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray,lineWidth: 0.5)
                )
                
            }
            .padding(.top)
            .padding(.horizontal,25)
            .padding(.bottom,10)
            
            if let products = homeData.searchedProducts{
                if products.isEmpty{
                    VStack(spacing: 10){
                        Text("Сұранысыңыз бойынша тауар табылмады")
                            .padding(.top,60)
                            .font(.system(size: 20, weight: .bold))
                        Text("Қайтадан көріңізші")
                            .padding(.top,60)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                else{
                    ScrollView(.vertical,showsIndicators: false){
                        VStack(spacing: 0){
                            
                            Text("\(products.count) тауар табылды")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.vertical)
                            
                            ForEach(products){ index in
                                ProductCardView(product: index)
                                    
                            }
//                            StaggeredGrid(columns: 2, spacing: 20,list: products){
//                                product in
//                                ProductCardView(product: product)
//                            }
                        }
                    }
                    .padding()
                }
            }
//            else{
//                ProgressView()
//                    .padding(.top,30)
//                    .opacity(homeData.seacrhText == "" ? 0 : 1)
//            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(Color("Back")
                        .ignoresSafeArea()
        )
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                startTF = true
            }
        }
        
    }
    @ViewBuilder
    func ProductCardView(product: Product)->some View{
        
        VStack(spacing:10){
            ZStack{
                if sharedData.showDetailProduct{
                    
                    KFImage (URL(string:product.productImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0)
                    
                }
                else{
                    KFImage (URL(string:product.productImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "\(String(describing: product.id))SEARCH", in: animation)
                }
            }
            
            
            Text(product.title)
                .font(.system(size: 18, weight: .semibold, design: .default))
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text("\(product.price)т")
                .font(.system(size: 18,weight: .bold))
                .foregroundColor(.blue)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
            
        )
        .padding(.top,50)
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
