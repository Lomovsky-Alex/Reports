//
//  BaseScene.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: - Protocol
protocol BaseSceneEvents {
  var unauthorizedEvent: Observable<Void> { get }
  var unexpectedErrorEvent: Observable<Void> { get }
  var responseErrorEvent: Observable<ErrorDTO> { get }
}

// MARK: - BaseScene
class BaseScene: UIViewController, BaseSceneEvents {
  
  // MARK: - Events
  var unauthorizedEvent: Observable<Void> {
    return Observable<Void>.empty()
  }
  var unexpectedErrorEvent: Observable<Void> {
    return Observable<Void>.empty()
  }
  var responseErrorEvent: Observable<ErrorDTO> {
    return Observable<ErrorDTO>.empty()
  }
  var isLoading: Driver<Bool> {
    return Driver<Bool>.empty()
  }
  
  // MARK: - SceneConfiguration
  var backgroundColor: UIColor {
    return .background
  }
  var sceneTitle: String {
    return ""
  }
  var shouldShowLargeTitle: Bool {
    return true
  }
  var largeTitleFont: UIFont {
    return .Montserrat.medium
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
    setupViews()
    bindEvents()
  }
  
  override var prefersHomeIndicatorAutoHidden: Bool {
    return true
  }
  
  // MARK: - UIMethods
  func setupConstraints() {}
  func bindEvents() {}
  func setupViews() {
    view.backgroundColor = backgroundColor
    navigationController?.navigationBar.prefersLargeTitles = shouldShowLargeTitle
    navigationController?.navigationBar.titleTextAttributes = [.font: largeTitleFont]
    navigationItem.title = sceneTitle
  }
  
}
