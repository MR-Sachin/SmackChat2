//
//  ProfileVCViewController.swift
//  SmackChat2
//
//  Created by vishal chaubey on 4/3/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

class ProfileVCViewController: UIViewController {
    @IBOutlet weak var ProfileImg: CircleImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupview()
        

    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func logOutBtnPressed(_ sender: Any) {
        //we call logoutUser()
        UserDataService.instance.logoutUser()
        //create a notification post when user data change it clear all data in which show when we login or register on channelVC and chatVC
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    //this method fetch user name,profiel color and email which we save in userDataService method through theres variable and show in this profile vc if user all ready loggedin if user not loggedIn just simply performSegue
    func setupview() {
        
            ProfileImg.image = UIImage(named: UserDataService.instance.avatarName)
            ProfileImg.backgroundColor = UserDataService.instance.returnUIColorFromServer(components: UserDataService.instance.avatarColor)
            userName.text = UserDataService.instance.name
            email.text = UserDataService.instance.email
        
        // touch screen respone when we tap on screen
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVCViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
