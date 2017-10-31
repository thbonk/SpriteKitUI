//
//  SKUIWidget+TouchEvents.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 31.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import UIKit

public extension SKUIWidget {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.downEvent()
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dragEvent()
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.upEvent()
    }
}
