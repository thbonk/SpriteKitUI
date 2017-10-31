//
//  SKUIScene.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

open class SKUIScene: SKScene {
    
    // MARK: - Private Properties
    
    private var panRecognizer: SKUIPanGestureRecognizer?
    

    // MARK: - Public Properties
    
    open private(set) var widgets = [SKUIWidget]()
    open internal(set) var focusedWidget: SKUIWidget?
    
    
    // MARK: - SKScene
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // Create pan gesture recognizer
        if self.panRecognizer == nil {
            self.panRecognizer = SKUIPanGestureRecognizer(target: self, action: #selector(SKUIScene.panGesture(_:)))
            
            // Don't cancel touches in view, so we can still get touchesMoved events
            #if os(macOS)
                self.panRecognizer!.isEnabled = true
            #elseif os(iOS)||os(tvOS)
                self.panRecognizer!.cancelsTouchesInView = false
            #endif
        }
        
        // Add gesture recognizers to view
        if (self.panRecognizer != nil) {
            view.addGestureRecognizer(self.panRecognizer!)
        }
    }
    
    open override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        // Remove gesture recogniers from view
        if (self.panRecognizer != nil) {
            view.removeGestureRecognizer(self.panRecognizer!)
        }
    }
    

    // MARK: - API
    
    open func panGesture(_ sender: SKUIPanGestureRecognizer) {
        if (self.focusedWidget != nil && self.focusedWidget!.wantsPanGestures) {
            self.focusedWidget!.panGesture(sender)
        }
    }
    
    open func addWidget(_ widget: SKUIWidget) {
        self.widgets.append(widget)
        if (widget.parentNode == nil) {
            widget.parentNode = self
        }
    }
    
    open func renderWidgets() {
        for widget in self.widgets {
            widget.render()
        }
    }
    
    open func getWidgets(_ named: String) -> [SKUIWidget] {
        return self.widgets.filter({
            $0.name == named
        })
    }
    
    open func updateWidgets() {
        for widget in self.widgets {
            widget.anchor()
        }
    }
    
    @discardableResult
    public func widgetInteractionBegan(locations: [CGPoint]) -> Bool {
        var handled = false
        
        for location in locations {
            for touchedNode in self.nodes(at: location) {
                var deeperTouch = touchedNode
                
                // determine actual sprite we should consider touched
                while deeperTouch.ignoreEvents && deeperTouch.parent != nil {
                    deeperTouch = deeperTouch.parent!
                }
                
                // see if the sprite belongs to any of our widgets
                for widget in self.widgets {
                    if widget.touchableSprite != nil && widget.touchableSprite == deeperTouch {
                        if (self.focusedWidget != nil) {
                            if (self.focusedWidget!.touchableSprite != deeperTouch) {
                                self.focusedWidget!.trigger(.blur)
                                widget.trigger(.blur)
                                self.focusedWidget = widget
                            }
                        } else {
                            widget.trigger(.focus)
                            self.focusedWidget = widget
                        }
                        
                        handled = true
                        break
                    }
                }
            }
        }
        
        if (!handled) {
            if (self.focusedWidget != nil) {
                self.focusedWidget!.trigger(.blur)
                self.focusedWidget = nil
            }
        }
        
        return handled
    }
    
    @discardableResult
    public func widgetMoveInteraction(locations: [CGPoint]) -> Bool {
        return self.widgetInteractionBegan(locations: locations)
    }
    
    @discardableResult
    public func widgetIntercationsEnded(locations: [CGPoint]) -> Bool {
        var handled = false
        
        if (self.focusedWidget != nil) {
            self.focusedWidget!.trigger(.blur)
            
            for location in locations {
                for touchedNode in self.nodes(at: location) {
                    var deeperTouch = touchedNode
                    
                    // determine actual sprite we should consider touched
                    while deeperTouch.ignoreEvents && deeperTouch.parent != nil {
                        deeperTouch = deeperTouch.parent!
                    }
                    
                    // is the sprite the same one we started touching in touchesBegan?
                    if self.focusedWidget!.sprite == deeperTouch {
                        self.focusedWidget!.trigger(.tap)
                        
                        handled = true
                        break
                    }
                }
            }
            
            self.focusedWidget = nil
        }
        
        return handled
    }
}
