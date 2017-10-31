//
//  SKUIPlatform.swift
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


#if os(macOS)
    public typealias SKUIResponder = NSResponder
    public typealias SKUIColor = NSColor
    public typealias SKUIPanGestureRecognizer = NSPanGestureRecognizer
#elseif os(iOS)||os(tvOS)
    public typealias SKUIResponder = UIResponder
    public typealias SKUIColor = UIColor
    public typealias SKUIPanGestureRecognizer = UIPanGestureRecognizer
#endif
