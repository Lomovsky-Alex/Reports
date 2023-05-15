//
//  Currency+Codes.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 20.03.2022.
//

import Foundation
import Unrealm

// MARK: - CurrencyCode
enum CurrencyCode: Int, Codable, RealmableEnumInt {
  case uah = 980
  case eur = 978
  case usd = 840
  case gbr = 826
  case jpy = 392
  case chf = 756
  case cny = 156
}
