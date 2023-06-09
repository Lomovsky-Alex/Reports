//
//  Router.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

//MARK: - Routable
protocol Routable: Presentable {
  func present(_ module: Presentable?)
  func present(_ module: Presentable?, animated: Bool)
  func present(_ module: Presentable?, with transition: UIModalTransitionStyle?)
  func present(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
  
  func push(_ module: Presentable?)
  func push(_ module: Presentable?, animated: Bool)
  func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
  
  func popModule()
  func popModule(animated: Bool)
  
  func dismissModule()
  func dismissModule(animated: Bool, completion: CompletionBlock?)
  
  func setRootModule(_ module: Presentable?)
  func setRootModule(_ module: Presentable?, animated: Bool)
  func setRootModule(_ module: Presentable?, with style: UIView.AnimationOptions)
  func setRootModule(_ module: Presentable?, hideBar: Bool)
  
  
  func popToRootModule(animated: Bool)
}

//MARK: - Router
final class Router: Routable {
  
  let rootController: UINavigationController
  private var completions: [UIViewController : CompletionBlock]
  
  init(rootController: UINavigationController) {
    self.rootController = rootController
    completions = [:]
  }
  
  func toPresent() -> UIViewController? {
    return rootController
  }
  
  func present(_ module: Presentable?) {
    present(module, animated: true)
  }
  
  func present(_ module: Presentable?, animated: Bool) {
    guard let controller = module?.toPresent() else { return }
    controller.modalPresentationStyle = .pageSheet
    rootController.present(controller, animated: animated, completion: nil)
  }
  
  func present(_ module: Presentable?, with transition: UIModalTransitionStyle? = nil) {
    guard let controller = module?.toPresent() else { return }
    controller.modalPresentationStyle = .overCurrentContext
    controller.modalTransitionStyle = transition ?? .coverVertical
    rootController.present(controller, animated: true, completion: nil)
  }
  
  func present(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
    guard let controller = module?.toPresent() else { return }
    if let completion = completion {
      completions[controller] = completion
    }
    rootController.pushViewController(controller, animated: animated)
  }
  
  func push(_ module: Presentable?) {
    push(module, animated: true)
  }
  
  func push(_ module: Presentable?, animated: Bool) {
    push(module, animated: animated, completion: nil)
  }
  
  func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
    guard let controller = module?.toPresent() else {
      assertionFailure("Deprecated push UINavigationController.")
      return
    }
    
    if let completion = completion {
      completions[controller] = completion
    }
    rootController.pushViewController(controller, animated: animated)
    
  }
  
  func popModule() {
    popModule(animated: true)
  }
  
  func popModule(animated: Bool) {
    rootController.popViewController(animated: animated)
  }
  
  func dismissModule() {
    dismissModule(animated: true, completion: nil)
  }
  
  func dismissModule(animated: Bool, completion: CompletionBlock?) {
    rootController.dismiss(animated: animated, completion: completion)
  }
  
  func setRootModule(_ module: Presentable?) {
    setRootModule(module?.toPresent(), hideBar: false)
  }
  
  func setRootModule(_ module: Presentable?, animated: Bool) {
    guard let controller = module?.toPresent() else { return }
    rootController.setViewControllers([controller], animated: true)
    UIApplication.shared.windows.first?.rootViewController = rootController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
  }
  
  func setRootModule(_ module: Presentable?, with style: UIView.AnimationOptions) {
    guard let window = UIApplication.shared.windows.first else { return }
    guard let controller = module?.toPresent() else { return }
    rootController.setViewControllers([controller], animated: false)
    window.rootViewController = rootController
    window.makeKeyAndVisible()
    UIView.transition(
      with: window,
      duration: 0.5,
      options: style,
      animations: nil,
      completion: nil)
  }
  
  func setRootModule(_ module: Presentable?, hideBar: Bool) {
    guard let controller = module?.toPresent() else { return }
    rootController.setViewControllers([controller], animated: false)
    rootController.isNavigationBarHidden = hideBar
    UIApplication.shared.windows.first?.rootViewController = rootController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
  }
  
  func popToRootModule(animated: Bool) {
    rootController.popToRootViewController(animated: animated)
  }
  
  func popToRootModule(animated: Bool, completion: CompletionBlock?) {
    
    guard let controller = rootController.viewControllers.first?.toPresent() else {
      assertionFailure("Deprecated push UINavigationController.")
      return
    }
    
    if let completion = completion {
      completions[controller] = completion
    }
    rootController.popToRootViewController(animated: animated)
  }
}
