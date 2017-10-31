//
//  SKUIMargins.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
#if os(iOS)||os(tvOS)
import UIKit
#endif

public class SKUIMargins {
    
    // MARK: - Public Properties
    
    open private(set)  var left: CGFloat
    open private(set)  var right: CGFloat
    open private(set)  var top: CGFloat
    open private(set)  var bottom: CGFloat
    
    open var horizontal: CGFloat {
        get {
            return self.left + self.right
        }
    }
    
    open var vertical: CGFloat {
        get {
            return self.top + self.bottom
        }
    }
    
    
    // MARK: - Initialization
    
    init (_ top: CGFloat, _ right: CGFloat, _ bottom: CGFloat, _ left: CGFloat) {
        self.top = top
        self.right = right
        self.bottom = bottom
        self.left = left
    }
}
