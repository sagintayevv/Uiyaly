//
//  ContentView.swift
//  Twitter
//
//  Created by Abat Sagintayev on 20.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if viewModel.userSession == nil {
            LoginView()
        }
        else{
                MainPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
