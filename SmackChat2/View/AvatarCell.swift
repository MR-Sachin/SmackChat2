//
//  AvatarCell.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/31/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    // now we setup uiivew for acatar cell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    //now we configure cell based on which segment you sellect
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
        
    }
    
    func setUpView()  {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10 //cell corner carve 
        self.clipsToBounds = true // image not expend to view
    }
}
