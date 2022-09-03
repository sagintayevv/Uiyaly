//
//  ProductDataView.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 27.12.2021.
//

import SwiftUI
import Kingfisher
struct ProductDetailView: View {
    
    let product:Product
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showMoreProductsOnType = false
    @EnvironmentObject var homeData: HomeViewModel
    
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Button{
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()
                    
                    Button{
                        addToLiked()
                    } label: {
                        Image("Таңдамалар" )
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }
                }.padding()
                
                
                TabView{
                    
                    ForEach(0..<5){ index in
                        
                        KFImage (URL(string:product.productImage))
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            }
            .frame(height: getRect().height / 2)
            .zIndex(1)
            
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment: .leading, spacing: 15){
                    Text(product.title)
                        .font(.system(size: 20, weight: .bold))
                    Text("Түсі: \(product.subtitle)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Button{
                        showMoreProductsOnType.toggle()
                    }
                label:{
                    Label{
                        Image(systemName: "pencil")
                            .foregroundColor(Color(.systemBlue))
                    }
                icon:{
                    Text("Пікірлер")
                        .font(.footnote)
                        .foregroundColor(Color(.gray))
                }
                }.padding(.top,10)
                    
                    HStack{
                        Text("Соммасы")
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price) т")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.blue)
                        
                    }
                    .padding(.vertical,20)
                    
                    Button{
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "Себетте" : "Себетке салу" )")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.blue
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }
                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white
                            .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                            .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color("Back").ignoresSafeArea())
        
        .sheet(isPresented: $showMoreProductsOnType){
        }
    content:{
        CommentsView()
    }
    }
    
    
    func isLiked()-> Bool{
        
        return sharedData.likedProducts.contains{
            product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()-> Bool{
        
        return sharedData.cartProducts.contains{
            product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: {
            product in
            return self.product.id == product.id
        }){
            sharedData.likedProducts.remove(at: index)
        }
        else{
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        if let index = sharedData.cartProducts.firstIndex(where: {
            product in
            return self.product.id == product.id
        }){
            sharedData.cartProducts.remove(at: index)
        }
        else{
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
