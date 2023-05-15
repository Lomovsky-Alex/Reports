//
//  AccountDTO.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import Foundation

struct AccountDTO: Codable {
  let id: String
  let iban: String
  let cashbackType: String?
  let type: CardTypeDTO
  let balance: Int
  let creditLimit: Int
  let currencyCode: CurrencyCode
  let maskedPan: [String]
}
