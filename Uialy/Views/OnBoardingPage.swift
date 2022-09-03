//
//  OnBoardingPage.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 20.12.2021.
//

import SwiftUI

struct OnBoardingPage: View {
    //Showing login Page
    @State var showLoginPage: Bool = false
    
    var body: some View {
        VStack{
            Text("Uialy")
                .font(.system(size: 25, weight: .semibold, design: .default))
                .foregroundColor(.white)
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Spacer()
            Button{
                withAnimation{
                    showLoginPage = true
                }
            }label: {
                Text("Начать")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .padding(.vertical,18)
                    .frame(maxWidth:.infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal,30)
            .offset(y:getRect().height < 750 ? 20:40)
            Spacer()
            
            
        }
        .padding()
        .padding(.top,getRect().height < 750 ? 0:20)
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(.blue)
        .overlay(Group{
            if showLoginPage{
                LoginView()
                    .transition(.move(edge: .bottom))
            }
        })
    }
}


extension View{
    
    func getRect ()->CGRect{
        return UIScreen.main.bounds
    }
}
