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

extension Responder {
  
  private static var styleHandlingObjectKey = "com.zetasq.SwiftStyle.Responder.styleHandlingObjectKey"
  
  private var styleHandlingObject: StyleHandlingObject {
    if let existingObject = objc_getAssociatedObject(self, &Responder.styleHandlingObjectKey) as? StyleHandlingObject {
      return existingObject
    } else {
      let newObject = StyleHandlingObject()
      objc_setAssociatedObject(self, &Responder.styleHandlingObjectKey, newObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return newObject
    }
  }
  
  public func registerForStyleChange<T: StyleProtocol>(type: T.Type, handler: @escaping StyleChangeHandler<T>) {
    styleHandlingObject.addStyleChangeHandler(handler)
  }
  
  public func removeStyleChange<T: StyleProtocol>(forType type: T.Type) {
    styleHandlingObject.removeStyleChangeHandler(forType: type)
  }
  
  public func styleDidChange<T: StyleProtocol>(_ style: T) {
    guard let handler = styleHandlingObject.styleChangeHandler(forType: T.self) else {
      return
    }
    handler(style)
  }
  
  public func applyCurrentStyle() {
    
  }
  
  private func applyStyleToSelfAndDescendants() {
    
  }
  
  private func applyStyle<T: StyleProtocol>(_ style: T) {
    
  }
  
}
