//
//  OnboardingSceneViewModel.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift
import RxCocoa

// MARK: - Protocols
protocol OnboardingSceneViewModelInput {
  var scrollViewOffset: AnyObserver<CGFloat> { get }
  var scrollViewTotalWidth: AnyObserver<CGFloat> { get }
  var pageControlTotalSteps: AnyObserver<Int> { get }
}

protocol OnboardingSceneViewModelOutput {
  var pageControlValue: Driver<Double> { get }
}

protocol OnboardingSceneViewModelType {
  var input: OnboardingSceneViewModelInput { get }
  var output: OnboardingSceneViewModelOutput { get }
  var bag: DisposeBag { get }
}

// MARK: - OnboardingSceneViewModel
final class OnboardingSceneViewModel:
  OnboardingSceneViewModelInput,
  OnboardingSceneViewModelOutput,
  OnboardingSceneViewModelType
{
  
  // MARK: - Lifecycle
  init() {
    bindEvents()
  }

  // MARK: - Input
  private let scrollViewOffsetSubject = BehaviorSubject<CGFloat>(value: .zero)
  var scrollViewOffset: AnyObserver<CGFloat> {
    return scrollViewOffsetSubject
      .asObserver()
  }
  private let scrollViewTotalWidthSubject = BehaviorSubject<CGFloat>(value: .zero)
  var scrollViewTotalWidth: AnyObserver<CGFloat> {
    return scrollViewTotalWidthSubject
      .asObserver()
  }
  private let pageControlTotalStepsSubject = BehaviorSubject<Int>(value: .zero)
  var pageControlTotalSteps: AnyObserver<Int> {
    return pageControlTotalStepsSubject
      .asObserver()
  }
  
  // MARK: - Type
  let bag = DisposeBag()
  var input: OnboardingSceneViewModelInput { return self }
  var output: OnboardingSceneViewModelOutput { return self }
  
  // MARK: - Output
  private let pageControlValueSubject = BehaviorSubject<Double>(value: .zero)
  var pageControlValue: Driver<Double> {
    return pageControlValueSubject
      .asDriver(onErrorJustReturn: .zero)
  }
  
  // MARK: - Private
  private func bindEvents() {
    Observable.combineLatest(
      scrollViewOffsetSubject.asObservable(),
      scrollViewTotalWidthSubject.asObserver(),
      pageControlTotalStepsSubject.asObservable(),
      resultSelector: { ($0, $1, $2) }
    )
    .map {(scrollOffset: Float($0.0), width: Float($0.1), stepsValue: Float($0.2))}
    .map {(
      scrollPercent: Calculator.calculatePercent(of: $0.scrollOffset, in: $0.width),
      stepsValue: $0.stepsValue
    )}
    .map { Calculator.calculateValue(fromPercent: $0.scrollPercent, totalValue: $0.stepsValue) }
    .map { Double($0) }
    .bind(to: pageControlValueSubject)
    .disposed(by: bag)
  }
}


