//
//  JKLongPress3DPreviewViewController.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/7/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JKLongPress3DPreviewViewController: UIViewController {
    
    var selectedPresident: JKPresidentInfo?
    var presidentFavoritedAction: ((JKPresidentInfo) -> ())?
    var presidentLiked: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView()
        if let selectedPresident = selectedPresident {
            imageView.image = UIImage(named: selectedPresident.name)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            self.view.addSubview(imageView)
            let views = ["imageView": imageView]
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[imageView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[imageView]-64-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        }
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        let actionTitle = presidentLiked == true ? "Unlike": "Like"
        let action1 = UIPreviewAction(title: actionTitle, style: .Default) { (action, controller) in
            if let president = self.selectedPresident {
                print("President \(president.name) was liked by the user")
                if let presidentFavoritedBlock = self.presidentFavoritedAction {
                    presidentFavoritedBlock(president)
                }
            }
        }
        
        let action2 = UIPreviewAction(title: "Cancel", style: .Destructive) { (action, controller) in
            print("Cancel Action Selected")
        }
        
        let actionGroup = UIPreviewActionGroup(title: "More Actions", style: .Default, actions: [action1, action2])
        
        let finalArray = NSArray.init(object: actionGroup)
        return finalArray as! [UIPreviewActionItem]
    }
    
}
