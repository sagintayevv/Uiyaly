//
//  AuthViewModel.swift
//  Twitter
//
//  Created by Abat Sagintayev on 20.01.2022.
//

import SwiftUI
import Firebase


class AuthViewModel:NSObject, ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthUser = false
    @Published var currentUser: User?
    @Published var adminSession: FirebaseAuth.User?
    @Published var currentAdmin: Seller?
    static let shared = AuthViewModel()
    private var tempUserSession: FirebaseAuth.User?
    private let service = UserService()
    
    override init() {
        super.init()
        self.userSession = Auth.auth().currentUser
        self.adminSession = Auth.auth().currentUser
        self.fetchUser()
        self.fetchAdmin()
    }
    
    func login(withEmail email : String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, _ in
            
            guard let user = result?.user else { return }
            
            self.userSession = user
          
            self.fetchUser()
        }
    }
    
    func register(withEmail email : String, password: String, fullname: String, username: String, n: Int, e: Int){
        Auth.auth().createUser(withEmail: email, password: password) { result, _ in
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let data = [
                        "email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "n": n,
                        "e": e,
                        "uid":user.uid] as [String : Any]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data){ _ in
                    self.didAuthUser = true
                }
        }
    }
    
    func adminlogin(withEmail email : String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("error\(String(describing: error?.localizedDescription))")
                return
            }
            guard let user = result?.user else { return }

            self.adminSession = user

            self.fetchAdmin()
        }
    }

    func registerAdmin(withEmail email : String, password: String, fullname: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error\(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }

            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname":fullname,
                        "uid":user.uid]

            Firestore.firestore().collection("admin")
                .document(user.uid)
                .setData(data){ _ in
                    self.didAuthUser = true
                }
        }
    }
    
    func signOut() {
        userSession = nil
        adminSession = nil
        try? Auth.auth().signOut()
    }

    func resetPassword(withEmail: String, resetCompletion:@escaping(Result<Bool,Error>) -> Void){
        
        Auth.auth().sendPasswordReset(withEmail: withEmail) { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            }
            else{
                resetCompletion(.success(true))
            }
        }
    }
    
    func uploadProfileImage(_ image:UIImage) {
        guard let uid = tempUserSession?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]){ _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
   
    func fetchUser(){
        guard let uid = self.userSession?.uid else{return}
        
        
        service.fetchUser(withUid: uid) { user in
            
            self.currentUser = user
        }
    }
    
    func fetchAdmin(){
        guard let uid = self.userSession?.uid else{return}

        service.fetchAdmin(withUid: uid) { user in

            self.currentAdmin = user
        }
    }
    
    
}
