//
//  JK3DTouchDestinationViewController.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/8/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JK3DTouchDestinationViewController: UIViewController {

    var selectedPresident: JKPresidentInfo?
    
    init?(president: JKPresidentInfo) {
        self.selectedPresident = president
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        if let selectedPresident = selectedPresident {
        
            self.title = selectedPresident.name
            
            let birthDateLabel = UILabel()
            birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
            birthDateLabel.textAlignment = NSTextAlignment.Center
            birthDateLabel.numberOfLines = 0
            birthDateLabel.text = "DOB: \(selectedPresident.birthDate)"
            
            let deathDateLabel = UILabel()
            deathDateLabel.translatesAutoresizingMaskIntoConstraints = false
            deathDateLabel.numberOfLines = 0
            deathDateLabel.textAlignment = NSTextAlignment.Center
            deathDateLabel.text = "DOD: \(selectedPresident.deathDate)"
            
            let birthLocationLabel = UILabel()
            birthLocationLabel.translatesAutoresizingMaskIntoConstraints = false
            birthLocationLabel.textAlignment = NSTextAlignment.Center
            birthLocationLabel.numberOfLines = 0
            birthLocationLabel.text = "Birth Place: \(selectedPresident.birthPlace)"

            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            let topLayoutGuide = self.topLayoutGuide
            
            let views: [String: AnyObject] = ["birthDateLabel": birthDateLabel, "deathDateLabel": deathDateLabel, "birthLocationLabel": birthLocationLabel, "imageView": imageView, "topLayoutGuide": topLayoutGuide]
            
            self.view.addSubview(birthDateLabel)
            self.view.addSubview(deathDateLabel)
            self.view.addSubview(birthLocationLabel)
            self.view.addSubview(imageView)
            
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[birthDateLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[deathDateLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[birthLocationLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[birthDateLabel]-[deathDateLabel]-[birthLocationLabel]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
            
            imageView.image = UIImage(named: selectedPresident.name)
            self.view.addSubview(imageView)
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[imageView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[birthLocationLabel]-[imageView]-44-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        }
    }
}