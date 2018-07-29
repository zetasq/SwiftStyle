//
//  StyleProcotol.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/29.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation

public protocol StyleProtocol {
  
}

extension StyleProtocol {
  
  public static var styleIdentifier: String {
    return String(reflecting: self)
  }
  
}

extension Notification.Name {
  
  public static let styleDidChange: Notification.Name = Notification.Name.init("com.zetasq.SwiftStyle.StyleDidChangeNotification")
  
}

public typealias StyleChangeHandler<T: StyleProtocol> = (T) -> Void
