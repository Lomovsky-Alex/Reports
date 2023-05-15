//
//  TabBarFlowDIContainer.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit

// MARK: - Protocol
protocol TabBarFlowDIContainer {
  func makeTabBarView(diContainer: TabBarFlowDIContainer) -> UITabBarController & TabBarType
  func makeBalanceScene() -> BaseScene & BalanceSceneEvents
}

// MARK: - TabBarFlowDIContainer
final class TabBarFlowDIContainerImpl: TabBarFlowDIContainer {
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func makeTabBarView(diContainer: TabBarFlowDIContainer) -> UITabBarController & TabBarType {
    return TabBarController(diContainer: diContainer)
  }
  
  func makeBalanceScene() -> BaseScene & BalanceSceneEvents {
    return BalanceScene(viewModel: makeBalanceSceneViewModel())
  }
  
  // MARK: - Private
  private func makeBalanceSceneViewModel() -> BalanceSceneViewModelType {
    return BalanceSceneViewModel(service: MonoServiceImpl())
  }
  
}
