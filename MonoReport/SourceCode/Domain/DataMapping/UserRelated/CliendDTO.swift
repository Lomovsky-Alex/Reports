//
//  CliendDTO.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 22.09.2022.
//

import Foundation
import Unrealm

// MARK: - DTO
struct ClientDTO: Codable {
  let clientId: String
  let name: String
  let accounts: [AccountDTO]
}
