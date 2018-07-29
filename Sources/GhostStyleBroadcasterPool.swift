//
//  GhostStyleBroadcasterPool.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/29.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation

internal final class GhostStyleBroadcasterPool {
  
  internal static let shared = GhostStyleBroadcasterPool()
  
  private var objectMap: [String: AnyObject] = [:]
  
  internal func styleBroadcaster<T: StyleProtocol>(forType type: T.Type) -> StyleBroadcaster<T> {
    let typeID = String(reflecting: T.self)
    
    if let existingBroadcaster = objectMap[typeID] as? StyleBroadcaster<T> {
      return existingBroadcaster
    } else {
      let newBroadcaster = StyleBroadcaster<T>()
      objectMap[typeID] = newBroadcaster
      return newBroadcaster
    }
  }
  
}
