//
//  Constants.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

typealias CompletionBlock = (() -> Void)
typealias ItemCompletionBlock<Item> = ((Item) -> Void)
typealias Scene = UIViewController
typealias BehaviorEvent = PublishRelay<Void>

public enum Constants {  
  enum PersistantStores {
    enum Keychain {
      
    }
    
    enum UserDefaults {
      static let authState = "account.authState"
      static let currentUser = "CurrentUser"
    }
  }
  
  enum Credentials {
    static let xtoken: [UInt8] = [
      52, 47, 60, 29, 9, 60, 107, 96, 2, 101, 117, 7, 9, 22, 26, 94,
      119, 102, 104, 121, 50, 35, 4, 44, 47, 67, 2, 81, 117, 89, 56, 10, 25,
      6, 75, 26, 124, 123, 90, 94, 49, 94, 57, 24
    ]
    static let obfuscatorSalt = ""
  }
}
