//
//  ProductDetailModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 03.02.2022.
//

import SwiftUI


class ProductDetailModel: ObservableObject {

    var product: Product
    @EnvironmentObject  var sharedData: SharedDataModel
    
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
