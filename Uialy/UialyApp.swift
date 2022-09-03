//
//  TwitterApp.swift
//  Twitter
//
//  Created by Abat Sagintayev on 20.01.2022.
//

import SwiftUI
import Firebase

@main
struct UialyApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(viewModel)
            
        }
    }
}
