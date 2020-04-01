//
//  Constants.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/29/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import Foundation

//renaming
typealias CompletionHandler = (_ Success:Bool) -> ()

// seque
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//Auth
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//Url Constant
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"

//header
let HEADER = ["Constant-Type": "application/JSON; charset=utf-8 "]
