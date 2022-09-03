//
//  CommentsView.swift
//  Uialy
//
//  Created by Abat Sagintayev on 14.02.2022.
//

import SwiftUI
import Kingfisher

struct CommentsView: View {
    
    let rsa: RSA? = RSA()
    
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ObservedObject var viewModel = UploadTweetViewModel()
    @ObservedObject var viewModelFeed = FeedViewModel()
    @State var showAlert = false

    
    var body: some View {
        VStack{
            HStack{
                Text("Пікірлер")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.top,20)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Spacer()
                
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label:{
                    Text("Жабу")
                        .foregroundColor(Color(.systemBlue))
                }
                .padding(.top,20)
                
            }
            .padding(.horizontal)
            
            
            ScrollView{
                LazyVStack{
                    ForEach(viewModelFeed.comments){ comment in
                        
                        CommentRowView(comment: comment)
                            .padding()
                        
                    }
                }
            }
            
            
            HStack{
                
                if let  user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                    
                    TextField("Жазыңыз...",text: $caption)
                        .foregroundColor(.black)
                        .padding(.leading,20)
                        .frame( height: 64)
                        .accentColor(Color(.systemBlue))
                    
                    Spacer()
                    
                    Button{
                        viewModel.uploadComment(withCaption: caption)
                    } label: {
                        Text("Жіберу")
                            .font(.footnote)
                            .padding(.horizontal)
                            .padding(.vertical,5)
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                }
                
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadComment) { success in
            if success{
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
