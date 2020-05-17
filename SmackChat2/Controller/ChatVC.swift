//
//  ChatVC.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/28/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // instead of menu buttom action we add target on menu button pressed
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!) //for slide gesture
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!) //tab on button show gestutre both show same gesture
        
        // add notification observer when
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        // if user logged in after close app and again open it first time load it check user logged in or not if they loggedIn then show user info on channel vc and profile vc
        
        if AuthServices.instance.isLoggedIn {
            // find user info by email and auth token which we set get in finduserbyemail function
            AuthServices.instance.findUserByEmail(completion: { (success) in
                // and info all over we logged in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
        MessageService.instance.findAllChannel { (success) in
            
        }
        
        //shooting out a notification that we have selected a channel so we need to add an observer for it so that we can listen for that notification
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification)  {
        // what happned in chatVC  when userDataDidchange
        if AuthServices.instance.isLoggedIn {
            // get channel name
            onLoginGetChannel()
        }else {
            channelNameLabel.text = "Please Log In"
        }
        
    }
    
    func onLoginGetChannel() {
        MessageService.instance.findAllChannel { (success) in
            // do stuff with channel
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
    }

}
