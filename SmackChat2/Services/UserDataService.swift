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
    
    
    func returnUIColorFromServer(components: String) -> UIColor {
        
        //scanner for scan string array of avatar color which parse form server in fome of array string
        let scanner = Scanner(string: components)
        //skipper that charater which is in string array which we "[0.4443333,0.5544333,0.4455333,0.5543332]"
        let skipped = CharacterSet(charactersIn: "[],")
        //stat scanning from comma
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        //avatar color in form of array string which we unwrapped and store in  r g b a variable
        var r, g, b, a:NSString?
        
        //scan array string upto(tak) comma
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray // if the unwrapped fail we need set default color
        // above r g b a value are optional so we need to unwrapped if is r g b a have value or not when we scan and store it
        guard let rUnWrapped = r else { return defaultColor}
        guard let gUnWrapped = g else { return defaultColor}
        guard let bUnWrapped = b else { return defaultColor}
        guard let aUnWrapped = a else { return defaultColor}
        
        //now we need cgFloat value of r g b a variable bez UIColor deal with cgFloat bez that class reture value uiclore bez we need color but we have r g b a value in string format but there is no direct conversion string to float  we convert first r g b a string value into double and then Float
        let rFloat = CGFloat(rUnWrapped.doubleValue)
        let gFloat = CGFloat(gUnWrapped.doubleValue)
        let bFloat = CGFloat(bUnWrapped.doubleValue)
        let aFloat = CGFloat(aUnWrapped.doubleValue)
        
        // now we going to do store r g b a value into newValue so we create a varible for this
        let newUiColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUiColor
    }
    
    // we create function perform all these variable set as empty and authosevice isLoggedIn set false and called that functin in profileVC 
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        name = ""
        email = ""
        
        AuthServices.instance.isLoggedIn = false
        AuthServices.instance.userEmail = ""
        AuthServices.instance.authToken = ""
        
        //  clean all channel name method call for clear list
        MessageService.instance.clearChannel()
        
    }
}

