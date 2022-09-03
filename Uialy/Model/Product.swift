//
//  Product.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 21.12.2021.
//

import SwiftUI
import FirebaseFirestoreSwift


struct Product:Identifiable,Hashable,Decodable{

    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String
    var quantity: Int = 1
    
}

//struct ProductImage:Identifiable,Hashable,Decodable{
//    var id = UUID().uuidString
//    var name: String
//
//}

enum ProductType: String,CaseIterable,Decodable{
    
    case Phones = "Смартфондар"
    case Laptops = "Ноутбуктер"
    case Wearable = "Сағаттар"
    case Tablets = "Планшеттер"
    
}
