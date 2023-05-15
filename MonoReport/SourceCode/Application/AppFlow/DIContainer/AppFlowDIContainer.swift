//
//  AppFlowDIContainer.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

// MARK: - Protocol
protocol AppDIContainer {
  func makeOnboardingDIContainer() -> OnboardingFlowDIContainer
  func makeTabBarFlowDIContainer() -> TabBarFlowDIContainer
}

// MARK: - AppDIContainer
final class AppDIContainerImpl: AppDIContainer {
  func makeOnboardingDIContainer() -> OnboardingFlowDIContainer {
    let dependencies = Dependencies(keychain: KeychainStorageManager.shared)
    return OnboardingFlowDIContainerImpl(dependencies: dependencies)
  }
  
  func makeTabBarFlowDIContainer() -> TabBarFlowDIContainer {
    let dependencies = Dependencies(keychain: KeychainStorageManager.shared)
    return TabBarFlowDIContainerImpl(dependencies: dependencies)
  }
}
