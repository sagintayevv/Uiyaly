//
//  cipher.swift
//  Uialy
//
//  Created by Abat Sagintayev on 12.03.2022.
//

import Foundation

class RSA: ObservableObject{
    
    @Published var publicKey: Int = 0
    @Published var privateKey: Int = 0
    
    init(){
        RSA()
    }
    func RSA(){
        
        self.publicKey = random()
        self.privateKey = random() 
       
    }
    
    func random () ->Int {
        
        let x = Int(arc4random_uniform(100))
        if isPrime(num:x) {
            return x
        }
        return random()
    }
    
    func E (phi: Int) ->Int {
        
        for e in 2..<phi {
            if phi%e == 1{
                return e
            }
        }
        return 0
    }
    
    func D (e:Int,phi: Int) ->Int {
        
        var k = 1
        
        while true {
            k += phi
            
            if k%e == 0 {
                let d = (k/e)
                return d
            }
        }
    }
    
    func isPrime(num: Int) -> Bool {
        if num < 2 {
            return false
        }
        
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
    }
    
    func encryption(text: Int, e: Int , n: Int) -> Int {
        
        var enc = text
        
        for _ in 0..<e - 1 {
            
            enc = (enc * text) % n
            
        }
        return enc
    }
    
    func decryption(encrypted: Int, d: Int , n: Int) -> Int {
        
        var dec = encrypted
        
        for _ in 0..<d - 1 {
            
            dec = (dec * encrypted) % n
            
        }
        return dec
    }
    
}
