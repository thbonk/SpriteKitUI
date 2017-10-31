//
//  SKNode+IgnoreEvents.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


public extension SKNode {
    
    public var ignoreEvents: Bool {
        get {
            let result = self.userData?.value(forKey: "SKUIIgnoreEvent")
            if (result != nil) {
                return result as! Bool
            } else {
                return false
            }
        }
        set {
            if (self.userData == nil) {
                self.userData = NSMutableDictionary()
            }
            self.userData?.setValue(newValue, forKey: "SKUIIgnoreEvent")
        }
    }
}
