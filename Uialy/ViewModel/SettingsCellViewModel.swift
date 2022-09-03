//
//  SettingsCellViewModel.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

enum SettingsCellViewModel: Int ,CaseIterable {
    case key
    
    
    var title: String {
        switch self {
        case.key: return "Кілттер"
        
        }
    }
    var imageName: String{
        switch self {
        case.key: return "key.fill"
        }
    }
    
    var backgroundColor: Color{
        switch self {
        case.key: return .blue
        }
    }
}
