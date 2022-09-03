//
//  AuthHeaderView.swift
//  Twitter
//
//  Created by Abat Sagintayev on 20.01.2022.
//

import SwiftUI

struct AuthHeaderView: View {
    
    let title1: String
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {Spacer()}
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            
        }
        .frame(height: 260)
        .padding(.horizontal,32)
        .foregroundColor(Color(.systemBlue))
    }
}

