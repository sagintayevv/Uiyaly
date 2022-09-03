//
//  Tab.swift
//  Uialy
//
//  Created by Abat Sagintayev on 07.02.2022.
//


import SwiftUI


struct TabImg: Identifiable,Hashable,Decodable{
    
    var id = UUID().uuidString
    var image: imageNum
}

enum imageNum: String,Decodable{
    
    case num1 = "Image1"
    case num2 = "Image2"
    case num3 = "Image3"
    case num4 = "Image4"
}
