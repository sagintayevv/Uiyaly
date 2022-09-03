//
//  ProductsUploadView.swift
//  Twitter
//
//  Created by Abat Sagintayev on 25.01.2022.
//


import SwiftUI
import Firebase


struct ProductsUploadView: View {
    @State private var title = ""
    @State private var subtitle = ""
    @State private var price = ""
    @State private var type = ""
    @Environment(\.presentationMode) var presentationMode

    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?


    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Button {
                    
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                Spacer()
                
                Text("Банк карталары")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
            }
            .padding(.bottom,40)
            
            Group{
                Text("Тауар атауы")
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "", isSecureField: false, text: $title)
                
                Text("Мәлімет")
                    .frame(alignment: .leading)
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "", isSecureField: false, text: $subtitle)
                
                
                Text("Типі")
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "", isSecureField: false, text: $type)
                
                Text("Бағасы")
                    .font(.system(size: 16, weight: .semibold))
                CustomInputField(imageName: "", placeholderText: "", isSecureField: false, text: $price)
                
            }
            
            Button{
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(product())
                        .clipShape(Circle())
                }
                else{
               
                    Text("Сурет жүктеу")
                        .font(.footnote)
                        .foregroundColor(Color(.systemBlue))
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(selectedImage: $selectedImage)
            }
            
            Spacer()
            if let selectedImage = selectedImage {
            Button{
                
                uploadProduct(selectedImage)
            }
        label: {
            Text("Жүктеу")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemBlue))
                .clipShape(Capsule())
            
        }
        .padding(.top,50)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
        }
        }
        .padding(.top,40)
        .padding(.horizontal)
    }
    
    func uploadProduct(_ image:UIImage) {
        
        ImageUploader.uploadImage(image: image) { productImage in
            
            Firestore.firestore().collection("ProductData")
                .document(UUID().uuidString)
                .setData(["title": title,
                          "subtitle": subtitle.lowercased(),
                          "type": type,
                          "price": price,
                          "productImage": productImage]){ (error) in
                    
                    if error != nil {
                        print("error")
                    }
                    else {
                        print ("success")
                }
            }
        }
    }
    func loadImage (){
        guard let selectedImage = selectedImage else{return}
        profileImage = Image(uiImage: selectedImage)
    }
}

private struct product: ViewModifier {
    func body(content: Content)-> some View{
        content
            .foregroundColor(Color(.systemBlue))
            .frame(width: 100, height: 100)
            .scaledToFit()
    }
}






