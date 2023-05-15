//
//  BalanceScene.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import FSPagerView

// MARK: - Protocol
protocol BalanceSceneEvents {
  var bag: DisposeBag { get }
}

// MARK: - BalanceScene
final class BalanceScene: ScrollableScene, BalanceSceneEvents {
  var bag: DisposeBag {
    return viewModel.bag
  }
  
  // MARK: - Events
  override var unexpectedErrorEvent: Observable<Void> {
    return viewModel.output.unexpectedErrorEvent
      .asObservable()
  }
  override var unauthorizedEvent: Observable<Void> {
    return viewModel.output.unauthorizedErrorEvent
      .asObservable()
  }
  override var responseErrorEvent: Observable<ErrorDTO> {
    return viewModel.output.responseErrorEvent
      .asObservable()
  }
  override var isLoading: Driver<Bool> {
    return viewModel.output.isLoading
  }
  
  // MARK: - SceneConfiguration
  override var shouldShowLargeTitle: Bool {
    return false
  }
  
  // MARK: - UIElements
  private let cardsContentView = UIView.createDefaultView()
  private let cardsPageView = FSPagerView.makeCardPageView()
  private let bottomContentView = UIView.createDefaultView()
  
  // MARK: - Lifecycle
  private let viewModel: BalanceSceneViewModelType
  
  init(viewModel: BalanceSceneViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    cardsContentView.setNeedsLayout()
    cardsContentView.layoutIfNeeded()
    cardsContentView.addBlurGradientBackground(
      colors: [.monoOrangeColor, .monoYellowColor],
      startPoint: .ViewPoint.bottomLeft,
      endPoint: .ViewPoint.bottomRight
    )
  }
  
  // MARK: - UIMethods
  override func setupConstraints() {
    super.setupConstraints()
    contentView.addSubview(cardsContentView)
    cardsContentView.snp.makeConstraints { make in
      make.top.equalTo(view.snp.top)
      make.left.right.equalToSuperview()
      make.height.equalTo(view.snp.width)
        .multipliedBy(LocalConstants.cardItemWidthMultiplier)
    }
    cardsContentView.addSubview(cardsPageView)
    cardsPageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeArea.top)
      make.left.right.bottom.equalToSuperview()
    }
    contentView.addSubview(bottomContentView)
    bottomContentView.snp.makeConstraints { make in
      make.top.equalTo(cardsPageView.snp.bottom).offset(-LocalConstants.edgeSpacing)
      make.left.right.bottom.equalToSuperview()
    }
  }
  
  override func setupViews() {
    super.setupViews()
    cardsPageView.register(CardPageViewCell.self)
    cardsPageView.itemSize = CGSize(
      width: view.bounds.width * LocalConstants.cardItemWidthMultiplier,
      height: view.bounds.width * LocalConstants.cardItemHeightMultiplier
    )
    cardsPageView.delegate = self
    cardsPageView.dataSource = self
    bottomContentView.backgroundColor = .background
    bottomContentView.makeCorners(
      radius: 15,
      maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    )
  }
  
  // MARK: - Binding
  override func bindEvents() {
    viewModel.output.isLoading
      .asObservable()
      .bind { status in
        Log.d(status)
        status ? BlurredLoader.show() : BlurredLoader.hide()
      }
      .disposed(by: bag)
    
    viewModel.output.updateCellsEvent
      .asObservable()
      .bind(onNext: { [weak self] in
        self?.cardsPageView.reloadData()
      })
      .disposed(by: bag)
    
    viewModel.input.viewDidLoadEvent.trigger()
  }
}

// MARK: - DataSource & Delegate
extension BalanceScene: FSPagerViewDelegate, FSPagerViewDataSource {
  func numberOfItems(in pagerView: FSPagerView) -> Int {
    return viewModel.output.cellModelsCount.value
  }
  
  func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    guard
      let cell = pagerView.dequeueReusableCell(
        withReuseIdentifier: CardPageViewCell.reuseIdentifier,
        at: index) as? FSPagerViewCellSetuppable,
      let model = viewModel.output.cellModels.value[safe: index] else { return FSPagerViewCell() }
    return cell.update(with: model)
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let edgeSpacing: CGFloat = 15
  static let cardItemWidthMultiplier: CGFloat = 0.85
  static let cardItemHeightMultiplier: CGFloat = 0.45
}
