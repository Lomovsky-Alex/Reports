//
//  OnboardingFlowCoordinator.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit
import RxSwift
import RxRelay

// MARK: - Protocols
protocol OnboardingFlowOutput {
  var finishFlowEvent: BehaviorEvent { get }
}

// MARK: - Coordinator
final class OnboardingFlowCoordinator: BaseCoordinator, OnboardingFlowOutput {
  private weak var navigationController: UINavigationController?
  private let diContainer: OnboardingFlowDIContainer

  
  // MARK: - Output
  let finishFlowEvent = BehaviorEvent()
  
  // MARK: - Lifecycle
  init(
    navigationController: UINavigationController,
    diContainer: OnboardingFlowDIContainer,
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
    showOnboardingScene()
  }
  
  // MARK: - Private
  private func showOnboardingScene() {
    let scene = diContainer.makeOnboardingScene()
    
    scene.loginEvent
      .bind(to: finishFlowEvent)
      .disposed(by: scene.bag)
    
    router.setRootModule(scene)
  }
}
