//
//  AuthorizationState.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

enum AuthorizationState: Codable {
  case unauthorized
  case authorized
  
  static func getAuthState() -> AuthorizationState? {
    return UserDefaults.standard.authState
  }
  
  static func updateState(to state: AuthorizationState) {
    UserDefaults.standard.authState = state
  }
}
