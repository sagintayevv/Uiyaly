//
//  ProductsViewModel.swift
//  Twitter
//
//  Created by Abat Sagintayev on 29.01.2022.
//



import SwiftUI
import Firebase


class ProductsViewModel: ObservableObject {
    
    @Published var products = [Product]()
    
    let service = ProductService()
    
    init(){
        fetchProduct()
    }
    
    func fetchProduct(){
        service.fetchProducts { product in
            self.products = product
        }
    }
    
}
