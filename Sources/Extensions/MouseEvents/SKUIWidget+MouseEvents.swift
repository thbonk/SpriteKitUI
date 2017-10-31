//
//  SKUIWidget+MouseEvents.swift
//  SpriteKitUI-macOS
//
//  Created by Thomas Bonk on 31.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import Cocoa

public extension SKUIWidget {
    
    override public func mouseDown(with event: NSEvent) {
        self.downEvent()
    }
    
    override public func mouseDragged(with event: NSEvent) {
        self.dragEvent()
    }
    
    override public func mouseUp(with event: NSEvent) {
        self.upEvent()
    }
}
