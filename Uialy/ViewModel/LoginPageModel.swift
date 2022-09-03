//
//  LoginPageModel.swift
//  EcommerceAppKit
//
//  Created by Abat Sagintayev on 20.12.2021.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    //login
    @Published var email: String=""
    @Published var password: String=""
    @Published var showPassword: Bool = false
    
    //register
    @Published var registerUser: Bool = true
    @Published var re_Enter_Password: String=""
    @Published var showReEnterpasword: Bool = false
    
    
    
    @AppStorage("log_status") var log_status: Bool = false
    
    //Login Call
    
    
    func Login(){
        withAnimation{
            log_status = true
        }
    }
    
    func Register(){
        
    }
    
    func ForgotPassword()
    {
        
    }
    
    
}
