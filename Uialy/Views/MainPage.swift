//
//  MainPage.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 21.12.2021.
//

import SwiftUI

struct MainPage: View {
    
    @State var currentTab: Tab = .Home
    @State var showMenu: Bool = false
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @EnvironmentObject var authviewmodel: AuthViewModel
    @Namespace var animation
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                if showMenu {
                    if let user = authviewmodel.currentUser{
                        SideMenuView(user: user,showMenu:$showMenu)
                    }
                }
                
                
                VStack(spacing:0){
                    
                    TabView(selection: $currentTab ){
                        
                        Home(showMenu:$showMenu,animation: animation)
                            .navigationBarTitleDisplayMode(.inline)
                            .environmentObject(sharedData)
                            .tag(Tab.Home)
                        
                        LikedPage(tab: $currentTab)
                            .navigationBarTitleDisplayMode(.inline)
                            .environmentObject(sharedData)
                            .tag(Tab.Liked)
                        
                        CartPage(tab: $currentTab)
                            .navigationBarTitleDisplayMode(.inline)
                            .environmentObject(sharedData)
                            .tag(Tab.Cart)
                        
                        ConversationsView()
                            .navigationBarTitleDisplayMode(.inline)
                            .environmentObject(sharedData)
                            .tag(Tab.Profile)
                        
                        
                    }
                    
                    HStack(spacing:0){
                        
                        ForEach(Tab.allCases,id:\.self){
                            tab in
                            
                            Button{
                                currentTab = tab
                            } label:{
                                VStack{
                                    Divider()
                                    Image(tab.rawValue)
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 27, height: 27)
                                        .foregroundColor(currentTab == tab ? Color(.systemBlue) : Color.black)
                                        .padding(.top)
                                    Text(tab.rawValue)
                                        .font(.system(size: 10))
                                        .foregroundColor(currentTab == tab ? Color(.systemBlue) : Color.black)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                .background(Color(.systemGroupedBackground))
                .offset(x: showMenu ? 300 : 0, y: showMenu ? 0 : 0)
                .frame(width: getRect().width)
                .overlay(
                    ZStack{
                        if let product = sharedData.detailProduct,sharedData.showDetailProduct{
                            
                            ProductDetailView(product: product, animation: animation)
                                .environmentObject(sharedData)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                        }
                    }
                )
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String,CaseIterable{
    case Home = "Басты"
    case Liked = "Таңдамалар"
    case Cart = "Себет"
    case Profile = "Көмек"
    
}
