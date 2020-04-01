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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        
        //create a variable and check they are not nil if they are return by guar let
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass  = passwordTxt.text, passwordTxt.text != ""  else {return}
        
        //pass email and password and register user
        AuthServices.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("register user!")
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
    }
    

}
