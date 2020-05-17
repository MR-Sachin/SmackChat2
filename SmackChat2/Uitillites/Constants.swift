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

//Color
let smackPurplePlaceHolder = #colorLiteral(red: 0.2588235294, green: 0.3176470588, blue: 0.6745098039, alpha: 0.4997859589)

//Notification
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("NotifiUserDataChange")
let NOTIF_CHANNELS_LOADED =  Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")

//Auth
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//Url Constant
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"


//header
let HEADER = ["Constant-Type": "application/JSON; charset=utf-8 "]

//here we saprete create varable for header instead of used constants which we creted already bez in that usercreate we need a authorizatio token
 let BEARER_HEADER =   [
    "Authorization": "Bearer\(AuthServices.instance.authToken)",
    "Content-Type": "application/json ; charset = utf-8"
]
