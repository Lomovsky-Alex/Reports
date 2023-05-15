//
//  Repo.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 24.08.2022.
//

import RxSwift
import RxCocoa

// MARK: - Protocol
protocol Repository {
  associatedtype T
  var error: Driver<ErrorEntity> { get }
    
  func fetchAll() -> Observable<[T]>
  func fetchOne() -> Observable<T>
  
  func retrieveAll() -> Observable<[T]>
  func retrieveOne() -> Observable<T?>
  
  func get(by id: String) -> Observable<T?>
  func save(object: T) -> Observable<Bool>
  func save(objects: [T]) -> Observable<Bool>
  
  func create(object: T) -> Observable<Bool>
  func create(object: Codable) -> Observable<Bool>
  
  func update(with id: String, object:T) -> Observable<Bool>
  func update(object: Codable) -> Observable<Bool>
  
  func delete(object: T) -> Observable<Bool>
  
}

// MARK: - Repo
class Repo<T>: Repository {
  // MARK: - Variables
  private let errorSubject = BehaviorSubject<ErrorEntity?>(nil)
  var error: Driver<ErrorEntity> {
    return errorSubject
      .asDriver(onErrorJustReturn: nil)
      .unwrap()
  }
  let bag = DisposeBag()
  
  // MARK: - Methods
  func fetchAll() -> Observable<[T]> {
    fatalError("concrete classes should implement this method")
  }
  
  func fetchOne() -> Observable<T> {
    fatalError("concrete classes should implement this method")
  }
  
  func retrieveAll() -> Observable<[T]> {
    fatalError("concrete classes should implement this method")
  }
  
  func retrieveOne() -> Observable<T?> {
    fatalError("concrete classes should implement this method")
  }
  
  func get(by id: String) -> Observable<T?> {
    fatalError("concrete classes should implement this method")
  }
  
  func save(object: T) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
  
  func save(objects: [T]) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
  
  func create(object: T) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
  
  func create(object: Codable) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
  
  func update(with id: String, object:T) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
  
  func update(object:Codable) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
  
  func delete(object: T) -> Observable<Bool> {
    fatalError("concrete classes should implement this method")
  }
}
