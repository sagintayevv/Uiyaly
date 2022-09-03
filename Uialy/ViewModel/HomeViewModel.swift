//
//  HomeViewModel.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 21.12.2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var showMoreProductsOnType : Bool = false
    @Published var seacrhText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    @Published var productType : ProductType = .Phones
    
    
    
    init(){
        getAllproducts()
        filterProductByType()
        searchCancellable = $seacrhText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    var searchCancellable: AnyCancellable?
    
    func getAllproducts(){
        Firestore.firestore().collection("ProductData").addSnapshotListener { [self] (snap, err) in
            guard let documents = snap?.documents else {return}
            
            self.products = documents.map { (queryDocumentSnapshot) -> Product in
                
                let data = queryDocumentSnapshot.data()
                let type = data["type"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let subtitle = data["subtitle"] as? String ?? ""
                let price = data["price"] as? String ?? ""
                let productImage = data["productImage"] as? String ?? ""
//                let productImage = data["productImage"] as? [String : [String : Any] ]
//
//                var prodArray = [ProductImage]()
//
//                if let productImage = productImage {
//                    for prod in productImage{
//                        let prodName = prod.value["name"] as? String ?? "error"
//                        prodArray.append(ProductImage(name: prodName))
//                    }
//                }
                return Product(type: ProductType(rawValue: type) ?? .Tablets,
                               title: title,
                               subtitle: subtitle,
                               price: price,
                               productImage: productImage)                
            }
            self.filterProductByType()
        }
        
    }
    
    func filterProductByType(){
        
        DispatchQueue.global(qos: .userInteractive).async{
            
            let results = self.products
                .lazy
                .filter{
                    product in
                    return product.type  == self.productType
                }
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        DispatchQueue.global(qos: .userInteractive).async{
            
            let results = self.products
                .lazy
                .filter{
                    product in
                    return product.title.lowercased().contains(self.seacrhText.lowercased())
                }
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
}

