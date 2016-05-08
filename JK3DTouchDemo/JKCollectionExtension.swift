//
//  JKCollectionExtension.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/8/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}