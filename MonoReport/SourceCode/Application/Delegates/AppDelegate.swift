//
//  AppDelegate.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var coordinatorFactory: CoordinatorFactory? {
    didSet {
      coordinator = coordinatorFactory?.makeAppFlowCoordinator()
    }
  }
  
  private var coordinator: Coordinatable? {
    didSet {
//      guard
//        let opt = coordinatorFactory?.deepLinkOptions
//      else {
      coordinator?.start(with: nil)
//        return
//      }
//      coordinator?.start(with: opt)
    }
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    setupWindow()
    return true
  }

  
  // MARK: - Private
  private func setupWindow() {
    let navController = UINavigationController()
    let win = UIWindow()
    coordinatorFactory = CoordinatorFactoryImpl(
      appDIContainer: AppDIContainerImpl(),
      navigationController: navController
    )
    window = win
    window?.makeKeyAndVisible()
  }

}

