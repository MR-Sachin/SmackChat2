//
//  Auth .swift
//  SmackChat2
//
//  Created by vishal chaubey on 4/1/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import Foundation
import Alamofire

class AuthServices {
   
    //create instance of this class which accessble globally and there can only be one instance of it at one time
    static let instance = AuthServices()
    
    //presisted data which hold data when user close app and come back same app state hold
    let defaults = UserDefaults.standard
    
    // now we are create 3 variable that will be able to access anywhere and also be reading and writing to and from our user defaults there variable will be be persisted accross app louncher
    var isLoggedIn: Bool {
        get {
        return defaults.bool(forKey: LOGGED_IN_KEY)
      }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToker:String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail:String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    func registerUser(email:String, password:String,completion:@escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        //create a json object just a replicating of register user in postman app
        
        let header = [
            "Constant-Type": "application/JSON; charset=utf-8 "
        ]
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString
            {(response) in
                if response.result.error == nil {
                    completion(true)
                }else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                    
                }
            
        }
    }
    
    
}
