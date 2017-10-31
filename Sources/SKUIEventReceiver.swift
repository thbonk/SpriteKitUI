//
//  SKUIEventReceiver.swift
//  SpriteKitUI
//
//  Created by Thomas Bonk on 30.10.17.
//  Copyright © 2017 Thomas Bonk. All rights reserved.
//

import Foundation
#if os(macOS)
    import Cocoa
#elseif os(iOS)||os(tvOS)
    import UIKit
#endif

public typealias SKUIEventHandler = () -> ()

public enum SKUIEventIdentifier: String {
    case tap    = "tap"
    case blur   = "blur"
    case focus  = "focus"
}

public class SKUIEventReceiver: SKUIResponder {

    // MARK: - Private Properties
    
    // Dictionary of events
    var events = [SKUIEventIdentifier: [String: SKUIEventHandler]]()
    
    
    // MARK: - Binding and Triggering Events
    
    /**
     Bind a handler to a named event
     */
    open func bind(_ event: SKUIEventIdentifier, _ handler: @escaping SKUIEventHandler) {
        self.bind(event, handler, forKey: UUID().uuidString)
    }
    
    /**
     Bind a handler to a named event with a given key
     */
    open func bind(_ event: SKUIEventIdentifier, _ handler: @escaping SKUIEventHandler, forKey: String) {
        if (self.events[event] == nil) {
            self.events[event] = [String: SKUIEventHandler]()
        }
        self.events[event]![forKey] = handler
    }
    
    /**
     Unbinds a handler from a named event for a given key, or all handlers for the named event if no key is specified.
     */
    open func unbind(_ event: SKUIEventIdentifier, _ key: String? = nil) {
        if (key == nil) {
            self.events[event]?.removeAll()
        } else {
            self.events[event]?.removeValue(forKey: key!)
        }
    }
    
    /**
     Trigger handler(s) for a named event.
     */
    open func trigger(_ event: SKUIEventIdentifier) {
        if (self.events[event] != nil) {
            for (_, handler) in self.events[event]! {
                handler()
            }
        }
    }
}
