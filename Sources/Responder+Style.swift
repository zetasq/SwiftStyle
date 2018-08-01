//
//  Responder+Style.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/28.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

#if os(macOS)

import AppKit

#elseif os(iOS)

import UIKit

#endif

import Beacon

extension Responder {
  
  private static var stylesTableKey = "com.zetasq.SwiftStyle.Responder.stylesTableKey"
  
  private final var stylesTable: BroadcastStylesTable {
    if let existingTable = objc_getAssociatedObject(self, &Responder.stylesTableKey) as? BroadcastStylesTable {
      return existingTable
    } else {
      let newTable = BroadcastStylesTable()
      objc_setAssociatedObject(self, &Responder.stylesTableKey, newTable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return newTable
    }
  }
  
  public final func registerForStyleChange<T>(type: T.Type, handler: @escaping (T) -> Void) {
    Beacon.default.addListener(self, broadcasterType: StyleBroadcaster<T>.self, broadcastIdentifier: .styleChanged) { [weak self] signal in
      guard let `self` = self else { return }
      
      guard self.isDescendantOrSelf(of: signal.payload.broadcastingResponder) else {
        return
      }
      
      handler(signal.payload.style)
    }
  }
  
  /// Call this method in viewWillAppear/didMoveToWindow
  ///
  /// - Parameters:
  ///   - type: The type of the style to apply
  ///   - handler: callback(noescaping) for available style
  public final func applyAvailableStyleIfPossible<T>(forType type: T.Type, handler: (T) -> Void) {
    var responder: Responder? = self
    
    while let currentResponder = responder {
      if let style = currentResponder.stylesTable.style(forType: T.self) {
        handler(style)
        break
      }
      
      responder = responder?.platformAgnosticNextResponder
    }
  }
  
  public final func broadcastStyle<T>(style: T) {
    stylesTable.saveStyle(style)
    
    let ghostBroadcaster = GhostStyleBroadcasterPool.shared.styleBroadcaster(forType: T.self)
    
    let payload = StyleBroadcaster.BroadcastPayload(style: style, broadcastingResponder: self)
    
    ghostBroadcaster.broadcast(identifier: .styleChanged, payload: payload)
  }
  
  // MARK: - Helper methods
  private final func isDescendantOrSelf(of target: Responder) -> Bool {
    
    var responder = self
    
    while responder !== target, let next = responder.platformAgnosticNextResponder {
      responder = next
    }
    
    return responder === target
  }
  
}
