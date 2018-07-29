//
//  StyleBroadcaster.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/29.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation
import Beacon

internal final class StyleBroadcaster<T: StyleProtocol>: SignalBroadcasting {
  
  internal enum BroadcastIdentifier: String, BroadcastIdentifiable {
    case styleChanged
  }
  
  internal struct BroadcastPayload {
    
    internal let style: T
    
    internal let broadcastingResponder: Responder
    
  }
  
}
