//
//  SKUIScene+MouseEvents.swift
//  SpriteKitUI-macOS
//
//  Created by Thomas Bonk on 31.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import Cocoa

public extension SKUIScene {
    
    override open func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        self.widgetInteractionBegan(locations: [event.location(in: self)])
    }
    
    override open func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        
        self.widgetMoveInteraction(locations: [event.location(in: self)])
    }
    
    override open func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        self.widgetIntercationsEnded(locations: [event.location(in: self)])
    }
}
