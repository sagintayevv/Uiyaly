//
//  Home.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 21.12.2021.
//

import SwiftUI
import Kingfisher


struct Home: View {
    @Binding var showMenu: Bool
    var animation:Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    @ObservedObject var homeModel = HomeViewModel()
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    @EnvironmentObject var auth : AuthViewModel
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing: 15){
                
                ZStack{
                    
                    HStack(spacing: 15){
                        Button{
                            showMenu.toggle()
                        } label: {
                            Image(systemName:"list.bullet")
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                        }
                        HStack{
                            if homeData.searchActivated{
                                SearchBar()
                            }
                            else{
                                SearchBar()
                                    .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                homeData.searchActivated = true
                            }
                        }
                    }
                    .padding(.horizontal,25)
                }
                
                Text("Online дүкен")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                ScrollView(.horizontal,showsIndicators: false){
                    
                    HStack(spacing:30){
                        ForEach(ProductType.allCases,id:\.self){
                            type in
                            Button{
                                withAnimation{
                                    
                                    homeData.productType = type
                                }
                            }
                        label:{
                            Text(type.rawValue)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(homeData.productType == type ? Color(.systemBlue) : Color.gray)
                                .padding(.bottom,10)
                                .overlay(
                                    
                                    ZStack{
                                        if homeData.productType == type {
                                            Capsule()
                                                .fill(Color(.systemBlue))
                                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                                .frame(height:2)
                                        }
                                        else{
                                            Capsule()
                                                .fill(Color.clear)
                                                .frame(height:2)
                                        }
                                    }
                                    .padding(.horizontal,-5),alignment: .bottom
                                )
                            }
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,25)
                
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:25){
                        
                        ForEach(homeData.filteredProducts){product in
                            
                            VStack(spacing:10){
                                ZStack{
                                        KFImage (URL(string:product.productImage))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                }
                                .frame(width:getRect().width / 2.5,height:getRect().width / 2.5)
                                .offset(y:-80)
                                .padding(.bottom,-80)
                                
                                Text(product.title)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                
                                Text("Түсі: \(product.subtitle)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                Text("\(product.price)т ")
                                    .font(.system(size:14,weight: .bold))
                                    .foregroundColor(Color(.systemBlue))
                            }
                            .padding(.horizontal,20)
                            .padding(.bottom,22)
                            .background(
                                Color.white
                                    .cornerRadius(25)
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    sharedData.detailProduct = product
                                    sharedData.showDetailProduct = true
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.top,80)
                    }
                    .padding(.top,20)
                    
                }
                
//                Button{
//
//                }
//            label:{
//                Label{
//                    Image(systemName: "arrow.right")
//                        .foregroundColor(Color(.systemBlue))
//                }
//            icon:{
//                Text("Толығырақ")
//                    .font(.system(size: 15, weight: .bold, design: .default))
//                    .foregroundColor(Color(.systemBlue))
//            }
//            }.frame(maxWidth:.infinity,alignment: .trailing)
//                    .padding(.trailing)
//                    .padding(.top,10)
//
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .onChange(of: homeData.productType){
            newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeModel.showMoreProductsOnType){
        }
    content:{
        CommentsView()
    }
    .overlay(
        ZStack{
            if homeData.searchActivated{
                SearchView(animation: animation)
                    .environmentObject(homeData)
            }
        }
    )
    }
    
    @ViewBuilder
    
    func SearchBar()-> some View{
        HStack(spacing:15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Іздеу",text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical,8)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray,lineWidth: 0.8)
        )
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

extension View{
    
    func getRect ()->CGRect{
        return UIScreen.main.bounds
    }
}
