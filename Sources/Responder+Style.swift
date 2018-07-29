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
  
  public final func registerForStyleChange<T: StyleProtocol>(type: T.Type, handler: @escaping (T) -> Void) {
    Beacon.default.addListener(self, broadcasterType: StyleBroadcaster<T>.self, broadcastIdentifier: .styleChanged) { [weak self] signal in
      guard let `self` = self else { return }
      
      guard self.isDescendantOrSelf(of: signal.payload.broadcastingResponder) else {
        return
      }
      
      handler(signal.payload.style)
    }
  }
  
  public final func deregisterForStyleChange<T: StyleProtocol>(forType type: T.Type) {
    Beacon.default.removeListener(self, broadcastingType: StyleBroadcaster<T>.self, identifier: .styleChanged)
  }
  
  public final func broadcastStyle<T: StyleProtocol>(style: T) {
    let ghostBroadcaster = GhostStyleBroadcasterPool.shared.styleBroadcaster(forType: T.self)
    
    let payload = StyleBroadcaster.BroadcastPayload(style: style, broadcastingResponder: self)
    
    ghostBroadcaster.broadcast(identifier: .styleChanged, payload: payload)
  }
  
  // MARK: - Helper methods
  private func isDescendantOrSelf(of target: Responder) -> Bool {
    
    var responder = self
    
    while responder !== target, let next = responder.next {
      responder = next
    }
    
    return responder === target
  }
  
}
