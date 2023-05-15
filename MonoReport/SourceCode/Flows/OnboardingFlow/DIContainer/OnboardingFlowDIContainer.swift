//
//  OnboardingFlowDIContainer.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

// MARK: - Protocol
protocol OnboardingFlowDIContainer {
  func makeOnboardingScene() -> Scene & OnboardingSceneEvents
}

// MARK: - DIContainer
final class OnboardingFlowDIContainerImpl: OnboardingFlowDIContainer {
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func makeOnboardingScene() -> Scene & OnboardingSceneEvents {
    return OnboardingScene(viewModel: makeOnboardingSceneViewModel())
  }
  
  // MARK: - Private
  private func makeOnboardingSceneViewModel() -> OnboardingSceneViewModelType {
    return OnboardingSceneViewModel()
  }
}
