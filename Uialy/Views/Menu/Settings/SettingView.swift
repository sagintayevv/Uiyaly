//
//  SettingView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    let user: User
    
    init (user: User){
        self.user = user
    }
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 32){
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("Баптаулар")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                }
                .padding(.bottom,40)
                
                if let user = viewModel.currentUser{
                NavigationLink(
                    destination: EditProfileView(user:user ).navigationBarHidden(true),
                    label: {SettingsHeaderView(user: user)})
                }
                VStack(spacing:1){
                    ForEach(SettingsCellViewModel.allCases, id: \.self) { viewModel in
                        SettingsCell(viewModel: viewModel)
                    }
                }
                
                Spacer()
            }.padding(.top,10)
            .padding(.horizontal)
            
            
        }
    }
}

