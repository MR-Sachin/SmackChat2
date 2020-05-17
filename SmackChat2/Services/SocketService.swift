//
//  SocketService.swift
//  SmackChat2
//
//  Created by vishal chaubey on 5/10/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    //create object/instance of this class
    static let instance = SocketService()
    
    // we create these variable bez new socket have multiple socketIOclient and these manage by socket manager
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init() {
        // now intailized above socket variable
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!) // force unwraped bez it ours hardCoded mension in contants file
        self.socket = manager.defaultSocket
        super.init()
    }
    
    // Now we need to add couple of function to connect or established the connection b/w our app or webServer/api when we/client open app so that function call in AppDelegate file bez when evar we open app these primary funtion call when we app open,close,terminate,pause app
    func establishConnection() {
        socket.connect()
    }
    
    // disconnection server
    func closeConnection()  {
        socket.disconnect()
    }
    
    
    //
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
    // emit from app to apiServer
    socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion : @escaping CompletionHandler)  {
        socket.on("channelCreated") { (dataArray, Acknowledge) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            
            
            let newChannel = Channel.init(channelTitle: channelName, channelDescription: channelDescription, id: channelID)
            
            MessageService.instance.channels.append(newChannel)
        }
    }
    
    
}
