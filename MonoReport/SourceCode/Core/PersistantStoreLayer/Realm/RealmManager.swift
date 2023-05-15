//
//  CoreDataManager.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 24.08.2022.
//

import Foundation
import Unrealm
import RxSwift
//
//final class RealmManager {
//
//  // MARK: - Lifecycle
//  static let shared = RealmManager()
//  private init() {}
//
//  // MARK: - Methods
//  func saveObject(_ object: Realmable) -> Observable<Bool> {
//    return Observable<Bool>.create { observer in
//      do {
//        try self.realm.write { [weak self] in
//          self?.realm.add(object, update: .modified)
//          observer.onNext(true)
//        }
//      } catch let error {
//        Log.e(error)
//        observer.onNext(false)
//      }
//      return Disposables.create()
//    }
//  }
//
//  func saveObjects(_ objects: [Realmable]) -> Observable<Bool> {
//    return Observable<Bool>.create { observer in
//      do {
//        try self.realm.write { [weak self] in
//          self?.realm.add(objects)
//          observer.onNext(true)
//        }
//      } catch let error {
//        Log.e(error)
//        observer.onNext(false)
//      }
//      return Disposables.create()
//    }
//  }
//
//
//  // MARK: - Private
//  private let realm = try! Realm()
//}
