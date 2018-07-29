//
//  PlatformNeutralTypes.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/28.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation

#if os(macOS)

  import AppKit

  public typealias Responder = NSResponder

  public typealias View = NSView

  public typealias ViewController = NSViewController

#elseif os(iOS)

  import UIKit

  public typealias Responder = UIResponder

  public typealias View = UIView

  public typealias ViewController = UIViewController

#endif
