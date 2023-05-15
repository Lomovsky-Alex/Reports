//
//  UserDefaults+Varriables.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

extension UserDefaults {
  
  // MARK: - AuthState
  var authState: AuthorizationState? {
    get {
      try? get(
        objectType: AuthorizationState.self,
        forKey: Constants.PersistantStores.UserDefaults.authState
      )
    }
    set {
      guard let status = newValue else { return }
      try? set(object: status, forKey: Constants.PersistantStores.UserDefaults.authState)
    }
  }
}
