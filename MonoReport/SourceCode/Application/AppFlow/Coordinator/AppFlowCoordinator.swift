//
//  AppFlowCoordinator.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - LaunchInstructor
private enum LaunchInstructor {
  case authorizationNeeded
  case authorized
  
  static func configure(authState: AuthorizationState? = AuthorizationState.getAuthState()) -> LaunchInstructor {
    switch authState {
      case .authorized:
        return .authorized
      default:
        return .authorizationNeeded
    }
  }
}

// MARK: - AppFlowCoordinator
final class AppFlowCoordinator: BaseCoordinator {
  private weak var navigationController: UINavigationController?
  private var launchInstructor: LaunchInstructor {
    return LaunchInstructor.configure()
  }
  private let appDIContainer: AppDIContainer
  
  init(
    navigationController: UINavigationController,
    appDIContainer: AppDIContainer,
    bag: DisposeBag
  ) {
    self.navigationController = navigationController
    self.appDIContainer = appDIContainer
    super.init(router: Router(rootController: navigationController), bag: bag)
  }
  
  override func start(with options: DeepLinks? = nil) {
    guard let _ = options else { start(); return }
  }
  
  override func start() {
    switch launchInstructor {
      case .authorizationNeeded:
        runOnboardingFlow()

      case .authorized:
        runTabBarFlow()
    }
  }
  
  // MARK: - Onboarding
  private func runOnboardingFlow() {
    guard let navigationController = navigationController else { return }
    let coordinatorFactory = CoordinatorFactoryImpl(
      appDIContainer: appDIContainer,
      navigationController: navigationController
    )
    
    let coordinator = coordinatorFactory.makeOnboardingFlowCoordinator()
    addDependency(coordinator: coordinator)
    
    coordinator.finishFlowEvent
      .bind(onNext: { [weak self, weak coordinator] in
        guard
          let self = self,
          let coordinator = coordinator else { return }
        AuthorizationState.updateState(to: .authorized)
        self.start()
        self.removeDependency(coordinator: coordinator)
      })
      .disposed(by: coordinator.bag)
    
    coordinator.start()
  }
  
  private func runTabBarFlow() {
    guard let navigationController = navigationController else { return }
    let coordinatorFactory = CoordinatorFactoryImpl(
      appDIContainer: appDIContainer,
      navigationController: navigationController
    )
    
    let coordinator = coordinatorFactory.makeTabBarFlowCoordinator()
    addDependency(coordinator: coordinator)
    
    coordinator.unauthorizedEvent
      .bind(onNext: { [weak self, weak coordinator] in
        guard
          let self = self,
          let coordinator = coordinator else { return }
        AuthorizationState.updateState(to: .authorized)
        self.start()
        self.removeDependency(coordinator: coordinator)
      })
      .disposed(by: coordinator.bag)
    
    coordinator.start()
  }
}
