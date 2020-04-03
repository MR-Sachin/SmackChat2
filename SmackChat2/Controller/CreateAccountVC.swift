//
//  CreateAccountVC.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/31/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"  // set defualt color combination red green blue alpha property
    var bgColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    // after selecting user profile image we need update user profile image
    override func viewDidAppear(_ animated: Bool) {
        // now check user profile (avatarName) still empty or not which we set as empty in userDataService class
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            //and also set local varible avatarName which used in  authserve in when createBtn pressed
            avatarName = UserDataService.instance.avatarName
            
        //
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        //create a variable and check they are not nil if they are return by guar let
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass  = passwordTxt.text, passwordTxt.text != ""  else {return}
        guard let userName = usernameTxt.text, usernameTxt.text != nil else {return}
        
        //pass email and password and register user
        AuthServices.instance.registerUser(email: email, password: pass)
        { (success) in
            if success {
                //print("register user!")
                AuthServices.instance.loginUser(email: email, password: pass, completion:
                    { (success) in
                    if success {
                        //print("login User \(AuthServices.instance.authToken)")
                        AuthServices.instance.createUser(name: userName, email: email, avatarName: self.avatarName, avatarColor:
                            self.avatarColor, completion:
                            { (success) in
                                if success {
                                    //print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                    self.spinner.isHidden = true
                                    self.spinner.stopAnimating()
                                    self.performSegue(withIdentifier: UNWIND, sender: nil)
                                    
                                    //
                                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                }
                        })
                    }
                    
                })
                
                
                
            }
        }
    }
    @IBAction func closedBtnPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func pickAvatarBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2 ){
            self.userImg.backgroundColor = self.bgColor
            
            self.avatarColor = "[\(r),\(g),\(b),1"
        }
    }
    
    
    // here we change placeholder color
    func setupView () {
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        
        // key borad dismiss when tap anywhere
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        // now add this gestureRecognizer to View
        view.addGestureRecognizer(tap)
    }
    
    //mehthod for hadler for end keyboard editing
    @objc func handleTap()  {
        view.endEditing(true)
    }

}
