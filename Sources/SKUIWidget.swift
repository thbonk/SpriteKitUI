//
//  SKUIWidget.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
#if os(macOS)
    import Cocoa
#elseif os(iOS)||os(tvOS)
    import UIKit
#endif

public class SKUIWidget: SKUIEventReceiver {

    // MARK: - Public Proiperties
    
    open var parentNode: SKNode?
    open var sprite: SKNode?
    
    fileprivate var _touchableSprite: SKNode?
    open var touchableSprite: SKNode? {
        get {
            return self._touchableSprite == nil ? self.sprite : self._touchableSprite
        }
        set {
            self._touchableSprite = newValue
        }
    }
    
    open var name: String = "Untitled"
    
    open var wantsPanGestures = false
    
    open var size = CGSize(width: 500,height: 200) {
        didSet {
            self.sizeDidChange()
        }
    }
    
    fileprivate var _position: CGPoint = CGPoint(x: 100,y: 100)
    open var position = CGPoint(x: 100,y: 100) {
        didSet {
            self.sprite?.position = self._position
        }
    }
    
    open var anchorPoint:CGPoint? {
        didSet {
            self.anchor()
        }
    }
    
    
    // MARK: - Initialization
    
    public convenience init(parentNode: SKNode) {
        self.init()
        self.parentNode = parentNode
    }
    
    override public init() {
        super.init()
    }
    
#if os(macOS)
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
#endif
    
    
    // MARK: - API
    
    open func sizeDidChange() {
        
    }
    
    open func render() {
        if (self.sprite != nil) {
            self.parentNode?.addChild(self.sprite!)
        }
        
        self.anchor()
    }
    
    open func hide() {
        if (self.sprite != nil) {
            self.sprite!.removeFromParent();
        }
    }
    
    /**
     Calculates position for the widget's sprite, based on anchorPoint, relative to parent
     container and respecting current theme margins
     */
    open func anchor() {
        if self.anchorPoint == nil
            || self.parentNode == nil
            || self.sprite == nil
            || self.sprite!.scene == nil
            || self.sprite!.scene!.view == nil {
            return
        }
        
        var width = self.parentNode!.frame.width
        var height = self.parentNode!.frame.height
        
        if width == 0 || height == 0 {
            width = (self.sprite!.scene?.view?.frame.width)!
            height = (self.sprite!.scene?.view?.frame.height)!
        }
        
        var x = self.position.x
        var y = self.position.y
        
        // Determine horizontal position
        if self.anchorPoint!.x == 1 { // right-align
            x = (width * self.anchorPoint!.x) - self.size.width - SKUITheme.instance.uiOuterMargins.right
        } else if self.anchorPoint!.x == 0 { // left-align
            x = 0 + SKUITheme.instance.uiOuterMargins.left
        } else { // center on width times anchoring
            x = (width * self.anchorPoint!.x) - (self.size.width/2)
        }
        
        
        // Determine vertical position
        if self.anchorPoint!.y == 1 { // top-align
            y = (height * self.anchorPoint!.y) - self.size.height - SKUITheme.instance.uiOuterMargins.top
        } else if (self.anchorPoint!.y == 0) { // bottom-align
            y = 0 + SKUITheme.instance.uiOuterMargins.bottom
        } else { // center on height times anchoring
            y = (height * self.anchorPoint!.y) - (self.size.height/2)
        }
        
        self.position = CGPoint(x: x,y: y)
    }
    
   
    open func panGesture(_ sender: SKUIPanGestureRecognizer) {   
    }
}
