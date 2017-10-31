//
//  SKUIScene+TouchEvents.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 31.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import UIKit

public extension SKUIScene {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.widgetInteractionBegan(locations: touches.map { $0.location(in: self) })
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        self.widgetMoveInteraction(locations: touches.map { $0.location(in: self) })
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        self.widgetIntercationsEnded(locations: touches.map { $0.location(in: self) })
    }
    
    
}
