//
//  SKUIButton.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class SKUIButton: SKUIWidget {

    // MARK: - Public Properties
    
    open internal(set) var caption: String = "Untitled"
    open internal(set) var fontName: String = "Avenir-Black"
    open internal(set) var fontSize: CGFloat = 20
    open internal(set) var color: SKUIColor = SKUIColor.black
    open internal(set) var strokeColor: SKUIColor = SKUIColor.black
    open internal(set) var backgroundColor: SKUIColor = SKUIColor.white
    open internal(set) var focusBackgroundColor: SKUIColor = SKUIColor.gray
    open internal(set) var focusColor: SKUIColor = SKUIColor.white
    open internal(set) var cornerRadius:CGFloat = 4
    open internal(set) var labelSprite: SKLabelNode?
    open internal(set) var autoSize: Bool = false
    open var hidden = false {
        didSet {
            self.sprite?.isHidden = self.hidden
        }
    }
    
    
    // MARK: - Initialization
    
    public override init() {
        super.init()
        self.size = CGSize(width: 200, height: 48)
    }
    
    public init(caption: String,
                size: CGSize = CGSize(width: 200, height: 48),
                position: CGPoint,
                cornerRadius: CGFloat = 4,
                fontName: String = "Avenir-Black",
                fontSize: CGFloat = 20) {
        super.init()
        
        self.caption = caption
        self.fontName = fontName
        self.fontSize = fontSize
        self.size = size
        self.position = position
        self.cornerRadius = cornerRadius
    }
    
#if os(macOS)
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
#endif
    
    
    // MARK: - API
    
    open override func render() {
        self.labelSprite = SKLabelNode(fontNamed: self.fontName)
        self.labelSprite!.text = self.caption
        self.labelSprite!.fontColor = self.color
        self.labelSprite!.fontSize = self.fontSize
        self.labelSprite!.horizontalAlignmentMode = .center
        self.labelSprite!.verticalAlignmentMode = .center
        
        self.labelSprite!.ignoreEvents = true
        
        if self.autoSize {
            self.size.width = self.labelSprite!.frame.width + 20
        }
        
        // Center label
        self.labelSprite!.position = CGPoint(x: ((self.size.width) / 2), y: ((self.size.height) / 2))
        
        let buttonRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        let buttonSprite = SKShapeNode(rect: buttonRect, cornerRadius: self.cornerRadius)
        buttonSprite.fillColor = self.backgroundColor
        buttonSprite.strokeColor = self.strokeColor
        buttonSprite.lineWidth = 0
        buttonSprite.position = self.position
        buttonSprite.isHidden = self.hidden
        
        buttonSprite.addChild(self.labelSprite!)
        
        self.sprite = buttonSprite
        
        self.bind(.focus,{
            (self.sprite as! SKShapeNode).fillColor = self.focusBackgroundColor
            self.labelSprite?.fontColor = self.focusColor
        });
        
        self.bind(.blur,{
            (self.sprite as! SKShapeNode).fillColor = self.backgroundColor
            self.labelSprite?.fontColor = self.color
        });
        
        super.render()
    }
    
    open override func sizeDidChange() {
        if self.sprite != nil {
            (self.sprite as! SKShapeNode).path = CGPath(
                roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height),
                cornerWidth: self.cornerRadius, cornerHeight: self.cornerRadius, transform: nil)
            self.labelSprite!.position = CGPoint(x: ((self.size.width) / 2), y: ((self.size.height) / 2))
        }
    }
}
