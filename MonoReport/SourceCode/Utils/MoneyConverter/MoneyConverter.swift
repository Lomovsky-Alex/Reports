//
//  MoneyConverter.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 20.03.2022.
//

import Foundation

// MARK: - MoneyConverter
struct MoneyConverter {
  static func getCardType(from card: String) -> CardProvider {
    guard let firstDigit = card.first else { return .unknown }
    switch firstDigit {
      case "4":
        return .visa
      case "5":
        return .mastercard
      default:
        return .unknown
    }
  }
  
  static func getCurrencyName(for code: CurrencyCode) -> String {
    switch code {
      case .uah:
        return "UAH"
      case .eur:
        return "EUR"
      case .usd:
        return "USD"
      case .gbr:
        return "GBR"
      case .jpy:
        return "JPY"
      case .chf:
        return "CHF"
      case .cny:
        return "CNY"
    }
  }
}
