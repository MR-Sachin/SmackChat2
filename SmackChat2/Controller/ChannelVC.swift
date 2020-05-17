//
//  ChannelVC.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/28/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        //when notification broadcase all over then this class also change data in self by add observer that listen that specific notification that class also react when or tune in when notfication fire up all over which we create in register user funtion see and check out
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelLoaded), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        
        // when api server response back when adding new channel then this class load new channel name display in table view
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    // if user already loggedin view appear
    override func viewDidAppear(_ animated: Bool) {
    // check user loggedin or not
      setupUserInfo()
    }
    @IBAction func addChannelPressed(_ sender: Any) {
        
        if AuthServices.instance.isLoggedIn {
         let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
      }
   }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
       //show profile image if user already loggedIn if not perform segue
        if AuthServices.instance.isLoggedIn {
            let profile = ProfileVCViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    //this funtion perform changes nd sent changes in notificaton add observer when call it that fucntion in selector
    @objc func userDataDidChange(_ notif:Notification)  {
        setupUserInfo()
    }
    
    @objc func channelLoaded() {
        tableView.reloadData()
    }
    
    
    func setupUserInfo()  {
        if AuthServices.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColorFromServer(components: UserDataService.instance.avatarColor)
        }else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            
            // reflact/reload data channelVC tableView data when logout it
            tableView.reloadData()
        }
    }
    
}

extension ChannelVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channels = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channels
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // menu slide back
        self.revealViewController()?.revealToggle(true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
