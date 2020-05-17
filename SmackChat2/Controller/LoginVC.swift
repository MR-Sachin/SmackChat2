//
//  LoginVC.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/29/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //spinner.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        //
        guard let email = userNameTxt.text , userNameTxt.text != nil else { return }
        guard let pass  = passwordTxt.text , passwordTxt.text != nil else { return }
        
        AuthServices.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthServices.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
                
            }
        }
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
        
        
    }
    
    //color provide for name and password text
    func setupView()  {
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "userName", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    }
}
