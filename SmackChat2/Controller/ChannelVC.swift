//
//  ChannelVC.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/28/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        //when notification broadcase all over then this class also change data in self by add observer that listen that specific notification that class also react when or tune in when notfication fire up all over which we create in register user funtion see and check out
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    //this funtion perform changes nd sent changes in notificaton add observer when call it that fucntion in selector
    @objc func userDataDidChange(_ notif:Notification)  {
        if AuthServices.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColorFromServer(components: UserDataService.instance.avatarColor)
        }else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }

    }
    
}
