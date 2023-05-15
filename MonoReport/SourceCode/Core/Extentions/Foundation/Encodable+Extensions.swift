//
//  Encodable+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
      .flatMap { $0 as? [String: Any] }
  }
  
  var data: Data? {
    return try? JSONEncoder().encode(self)
  }
}
