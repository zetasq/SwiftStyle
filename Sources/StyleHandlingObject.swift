//
//  StyleHandlingObject.swift
//  SwiftStyle
//
//  Created by Zhu Shengqi on 2018/7/29.
//  Copyright © 2018 Zhu Shengqi. All rights reserved.
//

import Foundation

public final class StyleHandlingObject {
  
  private var _table: [String: Any] = [:]
  
  public init() {}
  
  public func addStyleChangeHandler<T: StyleProtocol>(_ handler: @escaping StyleChangeHandler<T>) {
    _table[T.styleIdentifier] = handler
  }
  
  public func removeStyleChangeHandler<T: StyleProtocol>(forType type: T.Type) {
    _table[T.styleIdentifier] = nil
  }
  
  public func styleChangeHandler<T: StyleProtocol>(forType type: T.Type) -> StyleChangeHandler<T>? {
    return _table[T.styleIdentifier] as? StyleChangeHandler<T>
  }
  
}
