//
//  JK3DTouchPreviewViewController.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/7/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JK3DTouchPreviewViewController: UIViewController, UIViewControllerPreviewingDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    
    var favoritedList: [String] = []
    var listOfPresidents: [JKPresidentInfo] = [JKPresidentInfo(name: "Lincoln", birthDate: "02/1809", deathDate: "04/1865", birthPlace: "Hardin County"), JKPresidentInfo(name: "Roosevelt", birthDate: "01/1882", deathDate: "04/1945", birthPlace: "Hyde Park"), JKPresidentInfo(name: "Clinton", birthDate: "08/1946", deathDate: "N/A", birthPlace: "Hope"), JKPresidentInfo(name: "Obama", birthDate: "08/1961", deathDate: "N/A", birthPlace: "Honolulu")]
    
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        return longPressGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "3D Touch Preview"
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "presidentsCell")
        self.view.addSubview(tableView)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["tableView": tableView, "topLayoutGuide": topLayoutGuide]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][tableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        self.view.addGestureRecognizer(longPress)
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.check3DTouchEnabledFlag()
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        self.check3DTouchEnabledFlag()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPresidents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("presidentsCell", forIndexPath: indexPath)
        let president = listOfPresidents[indexPath.row]
        cell.textLabel?.text = president.name
        if (favoritedList.contains(president.name)) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .DisclosureIndicator
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let president = listOfPresidents[indexPath.row]
        if let destinationDetailsController = JK3DTouchDestinationViewController(president: president) {
            self.navigationController?.pushViewController(destinationDetailsController, animated: true)
        }
    }
    
    func check3DTouchEnabledFlag() {
        if self.traitCollection.forceTouchCapability  == UIForceTouchCapability.Available {
            self.registerForPreviewingWithDelegate(self, sourceView: self.view)
            self.longPress.enabled = false
            print("Force touch does exist")
        } else {
            self.longPress.enabled = true
            print("Force touch does not exists on this device")
        }
    }
    
    // MARK: - 3D touch delegate methods.
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if (self.presentedViewController?.isKindOfClass(JKLongPress3DPreviewViewController) == true) {
            return nil
        }
        
        var updatedLocation = tableView.convertPoint(location, toView: self.view)
        updatedLocation = CGPoint(x: location.x, y: location.y - 64)
        if let indexPath = tableView.indexPathForRowAtPoint(updatedLocation) {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
                previewingContext.sourceRect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y + 64, cell.bounds.width, cell.bounds.height)
                let president = listOfPresidents[indexPath.row]
                let selectedPresidentPreviewViewController = JKLongPress3DPreviewViewController()
                selectedPresidentPreviewViewController.selectedPresident = president
                selectedPresidentPreviewViewController.presidentLiked = self.presidentLikedWithName(president.name)
                selectedPresidentPreviewViewController.presidentFavoritedAction = { president in
                    if (self.presidentLikedWithName(president.name) == true) {
                        self.favoritedList.removeObject(president.name)
                    } else {
                        self.favoritedList.append(president.name)
                    }
                    self.tableView.reloadData()
                }
                return selectedPresidentPreviewViewController
            }
        }
        return nil
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        if let previewVC = viewControllerToCommit as? JKLongPress3DPreviewViewController, selectedPresident = previewVC.selectedPresident {
            if let destinationVC = JK3DTouchDestinationViewController(president: selectedPresident) {
                self.showViewController(destinationVC, sender: self)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where traitCollection.forceTouchCapability == .Available {
            let forceTouchInfo = "\(touch.force)\n\(touch.maximumPossibleForce)"
            NSLog("Force touch info %@", forceTouchInfo)
        }
    }
    
    func handleLongPress() {
        print("Long press button clicked")
    }
    
    func presidentLikedWithName(name: String) -> Bool {
        return self.favoritedList.contains(name)
    }
    
}
