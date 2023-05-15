//
//  OnboardingScene.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import CHIPageControl

// MARK: - Protocol
protocol OnboardingSceneEvents {
  var loginEvent: BehaviorEvent { get }
  var bag: DisposeBag { get }
}

// MARK: - OnboardingScene
final class OnboardingScene: Scene, OnboardingSceneEvents {
  
  // MARK: - Events
  let loginEvent = BehaviorEvent()
  var bag: DisposeBag {
    return viewModel.bag
  }
  
  // MARK: - UIElements
  private let scrollView = UIScrollView.createDefaultScroll()
  private let contentView = UIView.createDefaultView()
  private let firstOnboardingView = OnboardingView(
    image: .calendar,
    title: Localization.Onboarding.calendarSummary.localized(),
    subtitle: Localization.Onboarding.calendarSummaryDescription.localized()
  )
  private let secondOnboardingView = OnboardingView(
    image: .note,
    title: Localization.Onboarding.limits.localized(),
    subtitle: Localization.Onboarding.limitsDescription.localized()
  )
  private let thirdOnboardingView = OnboardingView(
    image: .hand,
    title: Localization.Onboarding.convenience.localized(),
    subtitle: Localization.Onboarding.convenienceDescription.localized()
  )
  private let pageControl = CHIPageControlAleppo.createDefaultPageControl()
  private let loginButton = AnimatableButton.createAnimatableButton()
  
  // MARK: - Lifecycle
  private let viewModel: OnboardingSceneViewModelType

  init(viewModel: OnboardingSceneViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
    setupViews()
    bindEvents()
  }
  
  // MARK: - UIMethods
  private func setupConstraints() {
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.centerY.equalToSuperview().offset(-LocalConstants.centerYOffset)
      make.centerX.equalToSuperview()
      make.left.equalTo(view.safeArea.left)
      make.right.equalTo(view.safeArea.right)
      make.height.equalToSuperview().multipliedBy(LocalConstants.viewHeightMultiplier)
    }
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.height.equalTo(view.snp.height).multipliedBy(LocalConstants.viewHeightMultiplier)
    }
    contentView.addSubview(firstOnboardingView)
    firstOnboardingView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview()
      make.width.equalTo(view.snp.width)
    }
    contentView.addSubview(secondOnboardingView)
    secondOnboardingView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.left.equalTo(firstOnboardingView.snp.right)
      make.width.equalTo(view.snp.width)
    }
    contentView.addSubview(thirdOnboardingView)
    thirdOnboardingView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.left.equalTo(secondOnboardingView.snp.right)
      make.width.equalTo(view.snp.width)
    }
    contentView.snp.makeConstraints { make in
      make.right.equalTo(thirdOnboardingView.snp.right)
    }
    view.addSubview(pageControl)
    pageControl.snp.makeConstraints { make in
      make.top.equalTo(scrollView.snp.bottom).offset(LocalConstants.edgeSpacing)
      make.centerX.equalToSuperview()
    }
    view.addSubview(loginButton)
    loginButton.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(LocalConstants.edgeSpacing)
      make.right.equalToSuperview().offset(-LocalConstants.edgeSpacing)
      make.bottom.equalTo(view.safeArea.bottom).offset(-LocalConstants.edgeSpacing)
      make.height.equalTo(LocalConstants.buttonHeight)
    }
  }
  
  private func setupViews() {
    view.addBlurGradientBackground(
      colors: [.monoOrangeColor, .monoYellowColor],
      startPoint: .ViewPoint.topLeft,
      endPoint: .ViewPoint.bottomRight
    )
    navigationController?.isNavigationBarHidden = true
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isPagingEnabled = true
    pageControl.numberOfPages = LocalConstants.numberOfPages
    pageControl.tintColor = .systemGray
    pageControl.currentPageTintColor = .orange
    pageControl.enableTouchEvents = false
    pageControl.radius = LocalConstants.pageControlRadius
    pageControl.padding = LocalConstants.pageControlPadding
    loginButton.makeCorners(radius: LocalConstants.cornerRadius)
    loginButton.backgroundColor = .orange
    loginButton.setTitle(Localization.Onboarding.login.localized(), for: .normal)
    loginButton.titleLabel?.set(font: .Montserrat.bold, size: LocalConstants.fontSize)
  }
  
  // MARK: - Binding
  func bindEvents() {
    scrollView.rx.contentOffset
      .map { $0.x }
      .bind(to: viewModel.input.scrollViewOffset)
      .disposed(by: bag)
    
    viewModel.input.scrollViewTotalWidth
      .onNext(view.frame.width * CGFloat(pageControl.numberOfPages))
    
    viewModel.input.pageControlTotalSteps
      .onNext(pageControl.numberOfPages)
    
    viewModel.output.pageControlValue
      .drive(pageControl.rx.progress)
      .disposed(by: bag)
    
    loginButton.rx.tap
      .bind(to: loginEvent)
      .disposed(by: bag)
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let centerYOffset: CGFloat = 50
  static let edgeSpacing: CGFloat = 30
  static let buttonHeight: CGFloat = 55
  static let cornerRadius: CGFloat = 15
  static let numberOfPages = 3
  static let pageControlRadius: CGFloat = 5
  static let pageControlPadding: CGFloat = 10
  static let viewHeightMultiplier: CGFloat = 0.5
  static let fontSize: CGFloat = 15
}
