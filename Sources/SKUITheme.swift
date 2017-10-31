//
//  SKUITheme.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class SKUITheme {
    
    // MARK: - Class Variables
    
    open static var instance = SKUITheme()
    
    open private(set) var frameworkBundle: Bundle = Bundle(for: SKUITheme.self)
    open private(set) var textures: SKTextureAtlas
    open private(set) var uiOuterMargins = SKUIMargins(20,20,20,20)
    open private(set) var uiInnerMargins = SKUIMargins(10,10,10,10)
    
    open private(set) var labelColor = SKUIColor.white
    open private(set) var labelBackground = SKUIColor.clear
    
    open private(set) var frameBackgroundColor = SKUIColor.white
    open private(set) var frameStrokeColor = SKUIColor.black
    
    fileprivate init() {
        self.textures = SKTextureAtlas(named: "SKUIGraphics")
    }
}
