//
//  GraudientView.swift
//  SmackChat2
//
//  Created by vishal chaubey on 3/29/20.
//  Copyright © 2020 DeviSons. All rights reserved.
//

import UIKit

//ibdesignable mean we enable to work on storyboard
@IBDesignable
class GradientView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    // this code provide option color change properties dynamically in inspectabel pannel
    @IBInspectable var topColor: UIColor = UIColor.purple {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }
    
    //create a override function for subview which we used as gradient layer
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
            // set gradient layer colors which a containt array
            gradientLayer.colors = [topColor, bottomColor]
        // start and end point of gradient layer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = bounds
        // now add this  gradient layer to uiview layer
        self.layer.insertSublayer(gradientLayer, at: 0)  // at 0 mean first layer
    }

}
