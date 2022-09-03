//
//  SideMenuViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 12.02.2022.
//

import Foundation
import SwiftUI


enum SideMenuViewModel: Int, CaseIterable {
    
    case profile
    case bankcards
    case cart
    
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .bankcards: return "Cards"
        case .cart: return "Cart"
        }
    }
}
