//
//  CoordinatorFactory.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit
import RxSwift

// MARK: - Protocol
protocol CoordinatorFactory {
  func makeAppFlowCoordinator() -> AppFlowCoordinator
  func makeOnboardingFlowCoordinator() -> BaseCoordinator & OnboardingFlowOutput
  func makeTabBarFlowCoordinator() -> BaseCoordinator & TabBarFlowOutput
}

// MARK: - CoordinatorFactory
final class CoordinatorFactoryImpl: CoordinatorFactory {
  let appDIContainer: AppDIContainer
  let navigationController: UINavigationController
  
  init(appDIContainer: AppDIContainer, navigationController: UINavigationController) {
    self.appDIContainer = appDIContainer
    self.navigationController = navigationController
  }
  
  func makeAppFlowCoordinator() -> AppFlowCoordinator {
    return AppFlowCoordinator(
      navigationController: navigationController,
      appDIContainer: appDIContainer,
      bag: DisposeBag()
    )
  }
  
  func makeOnboardingFlowCoordinator() -> BaseCoordinator & OnboardingFlowOutput {
    return OnboardingFlowCoordinator(
      navigationController: navigationController,
      diContainer: appDIContainer.makeOnboardingDIContainer(),
      bag: DisposeBag()
    )
  }
  
  func makeTabBarFlowCoordinator() -> BaseCoordinator & TabBarFlowOutput {
    return TabBarFlowCoordinator(
      navigationController: navigationController,
      diContainer: appDIContainer.makeTabBarFlowDIContainer(),
      bag: DisposeBag()
    )
  }
}

