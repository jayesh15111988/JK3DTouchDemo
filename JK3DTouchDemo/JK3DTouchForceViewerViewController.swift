//
//  JK3DTouchForceViewerViewController.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/7/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JK3DTouchForceViewerViewController: UIViewController {

    let forceValueLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Force Preview"
        
        let informationLabel = UILabel()
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.textAlignment = .Center
        informationLabel.text = "Move your finger anywhere on the screen to see the value of 3D touch force in action"
        informationLabel.numberOfLines = 0
        self.view.addSubview(informationLabel)
        
        forceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        forceValueLabel.textAlignment = .Center
        forceValueLabel.numberOfLines = 0
        forceValueLabel.text = "Force: 0"
        self.view.addSubview(forceValueLabel)
        
        let topLayoutGuide = self.topLayoutGuide
        
        let views: [String: AnyObject] = ["informationLabel": informationLabel, "forceValueLabel": forceValueLabel, "topLayoutGuide": topLayoutGuide]
        self.view.addConstraints(NSLayoutConstraint .constraintsWithVisualFormat("H:|-[informationLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint .constraintsWithVisualFormat("H:|-[forceValueLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint .constraintsWithVisualFormat("V:[topLayoutGuide]-[informationLabel]-[forceValueLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where traitCollection.forceTouchCapability == .Available {
            let forceTouchInfo = touch.force
            forceValueLabel.text = String(format: "Force: %.2f", forceTouchInfo)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first where traitCollection.forceTouchCapability == .Available {
            forceValueLabel.text = "Force: 0"
        }
    }
}
