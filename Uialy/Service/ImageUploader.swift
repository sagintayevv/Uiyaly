//
//  ImageUploader.swift
//  Twitter
//
//  Created by Abat Sagintayev on 21.01.2022.
//

import Firebase
import UIKit

struct ImageUploader {
    
    static func uploadImage(image:UIImage,completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            
            if error != nil {
                return
            }
            ref.downloadURL{ imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else{return}
                completion(imageUrl)
                
            }
        }
    }
}
