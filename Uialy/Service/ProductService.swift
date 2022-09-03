//
//  ProductService.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import Firebase

struct ProductService{
    
    func fetchProducts(completion: @escaping([Product]) -> Void){
        Firestore.firestore().collection("ProductData")
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            
            let products = documents.compactMap({
                try? $0.data(as: Product.self)
                
            })
            completion(products)
        }
    }
}

