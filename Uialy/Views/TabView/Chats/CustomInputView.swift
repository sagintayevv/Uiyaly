//
//  CustomInputView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 06.04.2022.
//

import SwiftUI

struct CustomInputView: View {
    
    @Binding var text: String
    
    var action: () -> Void
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            
            HStack{
                TextField("Жазыңыз...", text: $text)
                    .font(.body)
                    .accentColor(.blue)
                    .frame(minHeight: 30)
                
                Button{
                    action()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 27))
                        .foregroundColor(.blue)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

                }
            }
            .padding(.vertical,8)
            .padding(.horizontal)
            .background(
                Capsule()
                    .strokeBorder(Color(.separator),lineWidth: 0.8)
            )
           
        }
    }
}
