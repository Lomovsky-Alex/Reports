//
//  KeychainStorageManager.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation
import KeychainSwift

// MARK: - KeychainStorageManager
final class KeychainStorageManager {
  
  static let shared = KeychainStorageManager()
  private let keychain = KeychainSwift()

  private init() {}
  
  // MARK: - Codable
  @discardableResult
  func save<T: Codable>(object data: T, forUserAccount account: String) -> Bool {
    guard getObject(decodeBy: T.self, forUserAccount: account).isNil else {
      
      return true
    }
    guard let encoded = data.data else { return false }
    keychain.set(encoded, forKey: account)
    return true
  }
  
  @discardableResult
  func update<T: Codable>(object data: T, forUserAccount account: String) -> Bool {
    guard getObject(decodeBy: T.self, forUserAccount: account).isNotNil else {
      save(object: data, forUserAccount: account)
      return true
    }
    keychain.delete(account)
    return save(object: data, forUserAccount: account)
  }
  
  func getObject<T: Codable>(decodeBy: T.Type, forUserAccount account: String) -> T? {
    guard let data = keychain.getData(account) else { return nil }
    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return nil }
    return decodedData
  }
  
  // MARK: - String
  func save(text string: String, forUserAccount account: String) {
    guard getText(forUserAccount: account).isNil else {
      update(text: string, forUserAccount: account)
      return
    }
    keychain.set(string, forKey: account)
  }
  
  func getText(forUserAccount account: String) -> String? {
    guard let data = keychain.getData(account) else { return nil }
    return String(decoding: data, as: UTF8.self)
  }
  
  func update(text string: String, forUserAccount account: String) {
    guard getText(forUserAccount: account).isNotNil else {
      save(text: string, forUserAccount: account)
      return
    }
    keychain.delete(account)
    save(text: string, forUserAccount: account)
  }
}
