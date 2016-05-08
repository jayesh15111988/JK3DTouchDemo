//
//  JKShortcutItemIconTypes.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/7/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

enum ShortcutIconIdentifier: String {
    case AppMessaging
    case GoogleSearch
    case Gmail
    case CurrentDate
    
    init?(longShortcutString: String) {
        guard let shortShortcutItemString = longShortcutString.componentsSeparatedByString(".").last else {
            return nil
        }
        self.init(rawValue: shortShortcutItemString)
    }
}