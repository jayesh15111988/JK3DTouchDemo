//
//  AppDelegate.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/7/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        add3DTouchShortcutItems()        
        if let shortcutIconItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem  {
            handleShortcut(shortcutIconItem)
            return false;
        }
        return true
    }
    
    func add3DTouchShortcutItems() {
        var updatedShortcutItems = UIApplication.sharedApplication().shortcutItems
        let additionalShortcut = UIApplicationShortcutItem(type: "com.jayeshKawli.JK3DTouchDemo.CurrentDate", localizedTitle: "Date", localizedSubtitle: "Current Date", icon: UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.Date), userInfo: ["DateFormatter": "MM/dd/yyyy"])
        let newShortcutItems = [additionalShortcut]
        updatedShortcutItems?.appendContentsOf(newShortcutItems)
        UIApplication.sharedApplication().shortcutItems = updatedShortcutItems
    }
    
    // MARK: - Appdelegate methods for handling 3D touch peek actions.
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        completionHandler(handleShortcut(shortcutItem))
    }
    
    private func handleShortcut(shortcutItem: UIApplicationShortcutItem) -> Bool {
        let shortcutType = shortcutItem.type
        guard let shortcutEnumType = ShortcutIconIdentifier(longShortcutString: shortcutType) else {
            return false
        }
        launchViewControllerBasedOnShortcutType(shortcutEnumType)
        return true
    }
    
    func launchViewControllerBasedOnShortcutType(shortCutType: ShortcutIconIdentifier) {
        var navControllerTitle: String = ""
        var destinationURLString: String = ""
        switch shortCutType {
        case .AppMessaging:
            destinationURLString = "https://www.whatsapp.com/"
            navControllerTitle = "Application Messaging"
        case .GoogleSearch:
            destinationURLString = "https://www.google.com/"
            navControllerTitle = "Google Search"
        case .Gmail:
            destinationURLString = "https://www.gmail.com/"
            navControllerTitle = "Gmail"
        case .CurrentDate:
            destinationURLString = "https://www.timeanddate.com/"
            navControllerTitle = "Current Date"
        }
        
        if let presentedViewController = self.window?.rootViewController?.presentedViewController {
            presentedViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    
        if let url = NSURL(string: destinationURLString) {
            let vc = JKWebViewController(url: url)
            let nav = UINavigationController(rootViewController: vc)
            vc.title = navControllerTitle        
            self.window?.frame = UIScreen.mainScreen().bounds
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
        }
    }
}

