//
//  Auth .swift
//  SmackChat2
//
//  Created by vishal chaubey on 4/1/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    
    var authToken:String {
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
        
       
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString
            {(response) in
                if response.result.error == nil {
                    completion(true)
                }else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                    
                }

        }
    }
    
    func loginUser(email: String, password: String, completion:@escaping CompletionHandler)  {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON
            {(response) in
                if response.result.error == nil {
                    if let json = response.result.value as? Dictionary<String,Any> {
                        if let email = json["user"] as? String {
                            self.userEmail = email
                        }
                        if let token = json["token"] as?String {
                            self.authToken = token
                        }
                    }
                    self.isLoggedIn = true
                    completion(true)
                }else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
    func createUser(name:String,email:String,avatarName:String,avatarColor:String,completion:@escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body:[String:Any] = [
                                "name": name,
                                "email": lowerCaseEmail,
                                "avatarName": avatarName,
                                "avatarColor": avatarColor
                                ]
        
        //here we saprete create varable for header instead of used constants which we creted already bez in that usercreate we need a authorizatio token
        let header = [
            "Authorization": "Bearer\(AuthServices.instance.authToken)",
            "Content-Type": "application/json ; charset = utf-8"
                      ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            //if server response success store json format data into these variable mean parsing json data
            if response.result.error == nil {
                guard let data = response.data else { return}
                
                let json = JSON(data:data)
                let id  = json["_id"].stringValue
                let color  = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email  = json["email"].stringValue
                let name  = json["name"].stringValue
                
            
                // and save these data which holding above these variable to UserDataService class method userService
                UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                completion(true)
            
            }else {
               completion(false)
                debugPrint(response.result.error as Any)
            }
        
        }
    }
    
    
}
