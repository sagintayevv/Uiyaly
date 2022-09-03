//
//  MoreProductsView.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 22.12.2021.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        VStack{
            Text("More products")
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.top,20)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        .background(Color("Back"))
        .ignoresSafeArea()
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
