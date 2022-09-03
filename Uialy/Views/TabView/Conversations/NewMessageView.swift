//
//  NewMessageView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct NewMessageView: View {
    
    @Binding var showChatView: Bool
    @Environment(\.presentationMode) var mode
    @Binding var user: User?
    @ObservedObject var viewModel = NewMessageViewModel()
   
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                ForEach(viewModel.users){ user in
                    Button{
                        showChatView.toggle()
                        self.user = user
                        mode.wrappedValue.dismiss()
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
        }
    }
}


