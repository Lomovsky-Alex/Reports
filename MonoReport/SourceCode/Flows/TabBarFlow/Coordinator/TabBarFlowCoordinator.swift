//
//  TabBarFlowCoordinator.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift
import RxCocoa

// MARK: - Protocol
protocol TabBarFlowOutput {
  var unauthorizedEvent: BehaviorEvent { get }
  var logoutEvent: BehaviorEvent { get }
}

// MARK: - Coordinator
final class TabBarFlowCoordinator: BaseCoordinator, TabBarFlowOutput {
  private weak var navigationController: UINavigationController?
  private let diContainer: TabBarFlowDIContainer

  
  // MARK: - Output
  let unauthorizedEvent = BehaviorEvent()
  let logoutEvent = BehaviorEvent()
  
  // MARK: - Lifecycle
  init(
    navigationController: UINavigationController,
    diContainer: TabBarFlowDIContainer,
    bag: DisposeBag
  ) {
    self.navigationController = navigationController
    self.diContainer = diContainer
    super.init(router: Router(rootController: navigationController), bag: bag)
  }
  
  override func start(with options: DeepLinks? = nil) {
    guard let _ = options else { start(); return }
  }
  
  override func start() {
    showTabbBarView()
  }
  
  private func showTabbBarView() {
    let tabBarView = diContainer.makeTabBarView(diContainer: diContainer)
    
    router.setRootModule(tabBarView)
  }
}
