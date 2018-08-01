//
//  Responder+NeutralMethods.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 1/8/2018.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation

extension Responder {
  
  internal final var platformAgnosticNextResponder: Responder? {
    #if os(macOS)
      return nextResponder
    #elseif os(iOS)
      return next
    #endif
  }
  
}
