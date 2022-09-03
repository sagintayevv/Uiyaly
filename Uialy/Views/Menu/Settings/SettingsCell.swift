//
//  SettingsCell.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct SettingsCell: View {
    
    let viewModel: SettingsCellViewModel
    @EnvironmentObject var auth: AuthViewModel
    @State var key: RegistrationView = RegistrationView()
    @State var showKey: Bool = false
    var body: some View {
    
        Button{
            showKey.toggle()
        } label: {
            
                
                HStack{
                    Image(systemName: viewModel.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .padding(6)
                        .background(viewModel.backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    Text(viewModel.title)
                        .font(.system(size: 15))
                    Spacer()
                    if showKey {
                        HStack{
                            VStack{
                                Text(" Жабық кілт: (d:\(key.dkey),n:\(auth.currentUser!.n))")
                                    .font(.footnote)
                                Text(" Ашық кілт: (e:\(auth.currentUser!.e),n:\(auth.currentUser!.n))")
                                    .font(.footnote)
                            }
                        }
                    }
                }
                .padding(.top)
        }
    }
}
