//
//  MessageService.swift
//  SmackChat2
//
//  Created by vishal chaubey on 5/8/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER ).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    
                    //print(self.channels[0].channelTitle)
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                    
                }
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    // create a service method when logout clean all channel name in channel list from channel vc
    func clearChannel() {
        channels.removeAll()
    }

}

