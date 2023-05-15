//
//  Optional+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

// MARK: - Optional
public extension Optional {
  /// This method changes self to nil
  mutating func nullify() {
    self = nil
  }
  
  var isNil: Bool {
    return self == nil
  }
  
  var isNotNil: Bool {
    return !isNil
  }
}

public extension Optional where Wrapped == String {
  func orEmpty() -> String {
    return self ?? ""
  }
}

public extension Optional where Wrapped == Bool {
  func orFalse() -> Bool {
    return self ?? false
  }
  
  func orTrue() -> Bool {
    return self ?? true
  }
}

public extension Optional {
  func orEmpty<T>() -> [T] where Wrapped == Array<T> {
    return self ?? []
  }
}
