//
//  Rx+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import RxSwift
import RxCocoa

// MARK: - Observable
extension Observable {
  /// Skips first object in sequence
  func dropFirst() -> Observable<Element> {
    return skip(1)
  }
  
  /// Returns an `Observable` where the nil values from the original `Observable` are skipped
  func unwrap<T>() -> Observable<T> where Element == T? {
    compactMap { $0 }
  }
  
  /// Takes only first object
  func takeFirst() -> Observable<Element> {
    return take(1)
  }
  
  func asVoid() -> Observable<Void> {
    map { _ in Void() }
  }
}

// MARK: - ObservableType + Bool
extension ObservableType where Element == Bool {
  /// Reverts Bool to opposite value (true to false and etc.)
  func revert() -> Observable<Bool> {
    return asObservable().map { !$0 }
  }
  
  func trueOnly() -> Observable<Bool> {
    return asObservable().filter { $0 }
  }
  
  func falseOnly() -> Observable<Bool> {
    return asObservable().filter { !$0 }
  }
}

// MARK: - Driver
extension Driver {
  /// Returns an `Driver` where the nil values from the original `Driver` are skipped
  func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
    compactMap { $0 }
  }
  
  /// Skips first object in sequence
  func dropFirst() -> SharedSequence<SharingStrategy, Element> {
    return skip(1)
  }
}

// MARK: - ControlProperty
extension ControlProperty {
  /// Returns an `Observable` where the nil values from the original `Observable` are skipped
  func unwrap<T>() -> Observable<T> where Element == T? {
    compactMap { $0 }
  }
  
  /// Skips first object in sequence
  func dropFirst() -> Observable<Element> {
    return skip(1)
  }
}

// MARK: - PublishRelay
extension PublishRelay where Element == Void {
  /// This method is a cover for .accept(())
  func trigger() {
    accept(())
  }
}

// MARK: - ControlEvent
extension ControlEvent {
  /// Takes only first object
  func takeFirst() -> Observable<Element> {
    take(1)
  }
  
  /// Skips first object in sequence
  func dropFirst() -> Observable<Element> {
    skip(1)
  }
}

// MARK: - BehaviorRelay
extension BehaviorRelay {
  func asVoid() -> Observable<Void> {
    map { _ in Void() }
  }
}

// MARK: - BehaviorSubject
extension BehaviorSubject {
  convenience init(_ value: Element) {
    self.init(value: value)
  }
}
