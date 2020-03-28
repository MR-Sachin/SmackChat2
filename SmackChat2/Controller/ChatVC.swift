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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // instead of menu buttom action we add target on menu button pressed
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!) //for slide gesture
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!) //tab on button show gestutre both show same gesture
    }

}
