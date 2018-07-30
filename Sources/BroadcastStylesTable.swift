//
//  BroadcastStylesTable.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/30.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation

internal final class BroadcastStylesTable {
  
  private var _storage: [String: Any] = [:]
  
  internal func saveStyle<T>(_ style: T) {
    let typeID = String(reflecting: T.self)
    _storage[typeID] = style
  }
  
  internal func style<T>(forType type: T.Type) -> T? {
    let typeID = String(reflecting: T.self)
    return _storage[typeID] as? T
  }
  
}
