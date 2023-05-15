//
//  BaseCoordinator.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import RxSwift

//MARK: - Coordinatable
protocol Coordinatable: AnyObject {
  var childCoordinators: [Coordinatable] { get set }
  var bag: DisposeBag { get }
  var router: Routable { get }
  func start(with options: DeepLinks?)
  func addDependency(coordinator: Coordinatable)
  func removeDependency(coordinator: Coordinatable)
}

extension Coordinatable {
  
  func addDependency(coordinator: Coordinatable) {
    for element in childCoordinators {
      if element === coordinator { return }
    }
    childCoordinators.append(coordinator)
  }
  
  func removeDependency(coordinator: Coordinatable) {
    guard childCoordinators.isNotEmpty else { return }
    for (index, element) in childCoordinators.enumerated() {
      if element === coordinator {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
}

//MARK: - BaseCoordinator
class BaseCoordinator: Coordinatable {
  var childCoordinators = [Coordinatable]()
  var router: Routable
  let bag: DisposeBag
  
  init(router: Routable, bag: DisposeBag) {
    self.router = router
    self.bag = bag
  }
  
  func start() {}
  func start(with options: DeepLinks? = nil) {}
}

