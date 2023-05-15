//
//  TabBarController.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: - Protocols
protocol TabBarInput {
  
}

protocol TabBarOutput {
  var errorEvent: PublishRelay<ErrorDTO> { get }
  var unauthorizedEvent: BehaviorEvent { get }
  var unexpectedErrorEvent: BehaviorEvent { get }
}

protocol TabBarType {
  var input: TabBarInput { get }
  var output: TabBarOutput { get }
  var bag: DisposeBag { get }
}

// MARK: - TabBar
final class TabBarController:
  UITabBarController,
  TabBarInput,
  TabBarOutput,
  TabBarType
{
  
  // MARK: - Input
  
  // MARK: - Type
  var input: TabBarInput { return self }
  var output: TabBarOutput { return self }
  let bag = DisposeBag()
  
  // MARK: - Output
  let errorEvent = PublishRelay<ErrorDTO>()
  let unauthorizedEvent = BehaviorEvent()
  let unexpectedErrorEvent = BehaviorEvent()
  
  // MARK: - Lifecycle
  private let diContainer: TabBarFlowDIContainer
  
  init(diContainer: TabBarFlowDIContainer) {
    self.diContainer = diContainer
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    setupControllers()
    setupBlur()
    tabBar.tintColor = .orange
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if UIDevice.current.hasNotch {
      blurView.setNeedsLayout()
      blurView.layoutIfNeeded()
      blurView.makeCorners(radius: blurView.frame.height * LocalConstants.blurViewCornersMultiplier)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    blurView.snp.makeConstraints { make in
      if UIDevice.current.hasNotch {
        make.left.equalToSuperview().offset(LocalConstants.smallerSpacing)
        make.right.equalToSuperview().offset(-LocalConstants.smallerSpacing)
        make.bottom.equalToSuperview().offset(-LocalConstants.edgeSpacing)
        make.height.equalTo(tabBar.snp.height)
      } else {
        make.edges.equalToSuperview()
      }
    }
  }
  
  // MARK: - Appearance
  private let blurView = UIView.createDefaultView()

  private func setupBlur() {
    tabBar.insertSubview(blurView, at: .zero)
    blurView.blurBackground()
  }
  
  // MARK: - Controllers
  private var scenes = [UIViewController]()
  
  private func setupControllers() {
    let accounView = diContainer.makeBalanceScene()
    let balanceScene = UINavigationController(rootViewController: accounView)
    let balanceTab = UITabBarItem(
      title: Localization.TabBar.balance.localized(),
      image: UIImage.creditCardUnfilled,
      selectedImage: UIImage.creditCardFilled
    )
    balanceScene.tabBarItem = balanceTab
    scenes.append(balanceScene)
    
    let settingsScene = SettingsScene(viewModel: SettingsSceneViewModel())
    let settingsTab = UITabBarItem(
      title: Localization.TabBar.settings.localized(),
      image: UIImage.settingsUnfilled,
      selectedImage: UIImage.settingsFilled
    )
    settingsScene.tabBarItem = settingsTab
    scenes.append(settingsScene)
    
    viewControllers = scenes
  }
}

// MARK: - UITableViewDelegate
extension TabBarController: UITabBarControllerDelegate {
  func tabBarController(
    _ tabBarController: UITabBarController,
    shouldSelect viewController: UIViewController
  ) -> Bool {
    return true
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let edgeSpacing: CGFloat = 20
  static let smallerSpacing: CGFloat = 10
  static let blurViewCornersMultiplier: CGFloat = 0.37
}
