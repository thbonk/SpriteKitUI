//
//  SKUILabel.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 31.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class SKUILabel: SKUIWidget {
    
    // MARK: - Public Properties
    
    open internal(set) var caption: String = "Untitled"
    open internal(set) var fontName: String = "Avenir-Black"
    open internal(set) var fontSize: CGFloat = 20
    open internal(set) var color: UIColor = SKUITheme.instance.labelColor
    open internal(set) var backgroundColor: UIColor = SKUITheme.instance.labelBackground
    open internal(set) var labelSprite: SKLabelNode?
    open internal(set) var verticalAlignment = SKLabelVerticalAlignmentMode.bottom
    open internal(set) var horizontalAlignment = SKLabelHorizontalAlignmentMode.left
    
    
    // MARK: - Initialization
    
    override public init() {
        super.init()
        self.size = CGSize(width: 200, height: 48)
    }
    
    public init(caption: String,
                size: CGSize = CGSize(width: 200, height: 48),
                position: CGPoint,
                horizontalAlignment: SKLabelHorizontalAlignmentMode = .left,
                verticalAlignment: SKLabelVerticalAlignmentMode = .bottom,
                fontName: String = "Avenir-Black",
                fontSize: CGFloat = 20) {
        super.init()
        
        self.caption = caption
        self.size = size
        self.position = position
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.fontName = fontName
        self.fontSize = fontSize
    }
    
    
    // MARK: - API
    
    override open func render() {
        self.labelSprite = SKLabelNode(fontNamed: self.fontName)
        self.labelSprite!.text = self.caption
        self.labelSprite!.fontColor = self.color
        self.labelSprite!.fontSize = self.fontSize
        self.labelSprite!.horizontalAlignmentMode = self.horizontalAlignment
        self.labelSprite!.verticalAlignmentMode = self.verticalAlignment
        self.labelSprite!.position =
            CGPoint(x: SKUITheme.instance.uiInnerMargins.left,
                    y: SKUITheme.instance.uiInnerMargins.bottom)
        self.labelSprite!.ignoreEvents = true
        
        // Automatically resize
        self.size.width = self.labelSprite!.frame.size.width + SKUITheme.instance.uiInnerMargins.horizontal
        self.size.height = self.labelSprite!.frame.size.height + SKUITheme.instance.uiInnerMargins.vertical
        
        let frameRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        let frameSprite = SKShapeNode(rect: frameRect)
        frameSprite.fillColor = self.backgroundColor
        frameSprite.position = self.position
        frameSprite.lineWidth = 0
        frameSprite.ignoreEvents = true
        
        frameSprite.addChild(self.labelSprite!)
        
        self.sprite = frameSprite
        
        super.render()
    }
}
