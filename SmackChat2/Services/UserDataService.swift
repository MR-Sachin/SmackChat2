//
//  UserDataService.swift
//  SmackChat2
//
//  Created by vishal chaubey on 4/2/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import Foundation

class UserDataService {
    //create instance of this class which we used later for servar requesting
    static let instance = UserDataService()
    
    //create local variable for parsing json data into here
    public private (set) var id = ""
    public private (set) var avatarColor = ""
    public private (set) var avatarName = ""
    public private (set) var email = ""
    public private (set) var name = ""
    
    // now we set these variable bez we made these private sets
    func setUserData(id: String, color:String,avatarName:String,email:String,name:String) {
        //now we need to pass into it this fuction bez
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    //something that we're use later
    func setAvatarName(avatarName: String)  {
        self.avatarName = avatarName
    }
}
