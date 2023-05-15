//
//  String+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

// MARK: - Localized
public extension String {
  func localized() -> String {
    return NSLocalizedString(self, comment: "")
  }
}

// MARK: - Symbols
public extension String {
  enum Separators {
    static let space = " "
    static let comma = ","
    static let star = "*"
    static let slash = "/"
    static let fullstop = "."
  }
  
  enum Symbols {
    static let questionMark = "?"
  }
}

// MARK: - Emoji
public extension String {
  enum Emoji {
    static let hand = "👋"
  }
}

// MARK: - Acronyms
public extension String {
  func getAcronyms(separator: String = "") -> String {
    let acronyms = components(separatedBy: String.Separators.space)
      .map({ String($0.first ?? " ") }).joined(separator: separator)
    return acronyms
  }
}
