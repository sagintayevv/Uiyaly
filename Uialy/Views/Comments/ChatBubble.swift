//
//  ChatBubble.swift
//  Uialy
//
//  Created by Abat Sagintayev on 26.02.2022.
//

import SwiftUI

struct ChatBubble: Shape {
    
    var myMsg : Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,myMsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        
        return Path(path.cgPath)
    }
    
}

