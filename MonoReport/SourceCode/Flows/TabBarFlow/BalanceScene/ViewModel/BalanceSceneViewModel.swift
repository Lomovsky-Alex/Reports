//
//  BalanceSceneViewModel.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocols
protocol BalanceSceneViewModelInput {
  var viewDidLoadEvent: BehaviorEvent { get }
}

protocol BalanceSceneViewModelOutput {
  var isLoading: Driver<Bool> { get }
  var unexpectedErrorEvent: BehaviorEvent { get }
  var unauthorizedErrorEvent: BehaviorEvent { get }
  var responseErrorEvent: PublishRelay<ErrorDTO> { get }
  var updateCellsEvent: BehaviorEvent { get }
  var cellModels: BehaviorRelay<[FSPagerViewCellViewModel]> { get }
  var cellModelsCount: BehaviorRelay<Int> { get }
}

protocol BalanceSceneViewModelType {
  var input: BalanceSceneViewModelInput { get }
  var output: BalanceSceneViewModelOutput { get }
  var bag: DisposeBag { get }
}

// MARK: - BalanceSceneViewModel
final class BalanceSceneViewModel:
  NSObject,
  BalanceSceneViewModelInput,
  BalanceSceneViewModelOutput,
  BalanceSceneViewModelType
{
  
  // MARK: - Input
  let viewDidLoadEvent = BehaviorEvent()
  
  // MARK: - Type
  var input: BalanceSceneViewModelInput { return self }
  var output: BalanceSceneViewModelOutput { return self }
  let bag = DisposeBag()
  
  // MARK: - Output
  let cellModelsCount = BehaviorRelay<Int>(value: 0)
  let cellModels = BehaviorRelay<[FSPagerViewCellViewModel]>(value: [])
  let unexpectedErrorEvent = BehaviorEvent()
  let unauthorizedErrorEvent = BehaviorEvent()
  let responseErrorEvent = PublishRelay<ErrorDTO>()
  let updateCellsEvent = BehaviorEvent()
  var isLoading: Driver<Bool> {
    return Driver<Bool>
      .combineLatest(
        service.isLoading.asDriver(onErrorJustReturn: false),
        isProcessingSubject.asDriver(onErrorJustReturn: false),
        resultSelector: { ($0 || $1) })
  }
  
  // MARK: - Lifecycle
  private let service: MonoService
  
  init(service: MonoService) {
    self.service = service
    super.init()
    bindEvents()
  }
  
  deinit {
    Log.d("Deallocating \(self)")
  }
  
  // MARK: - Private
  private let isProcessingSubject = BehaviorSubject<Bool>(value: false)
  private let clientModelSubject = BehaviorSubject<ClientDTO?>(value: nil)
  
  private func loadClientInfo() {
    isProcessingSubject.onNext(true)
    service.fetchClientInfo()
      .subscribe { [weak self] model in
        self?.clientModelSubject.onNext(model)
        self?.isProcessingSubject.onNext(false)
      } onError: { [weak self] error in
        self?.isProcessingSubject.onNext(false)
        if let responseError = error as? ErrorDTO {
          self?.responseErrorEvent.accept(responseError)
        } else {
          self?.unexpectedErrorEvent.trigger()
        }
      }
      .disposed(by: bag)
  }
  
  private func getImage(for cardProvider: CardProvider) -> UIImage? {
    switch cardProvider {
      case .visa:
        return .visa
      case .mastercard:
        return .mastercard
      case .unknown:
        return .creditCardUnfilled
    }
  }
  
  // MARK: - Binding
  private func bindEvents() {
    viewDidLoadEvent
      .bind(onNext: { [weak self] in
        self?.loadClientInfo()
      })
      .disposed(by: bag)
    
    let clientModelObservable = clientModelSubject
      .unwrap()
      .share()
    
    let cellModelsObservable = clientModelObservable
      .observe(on: DispatchQueueScheduler.userInitiatedSerial)
      .map { ($0.accounts) }
      .withLatestFrom(clientModelObservable, resultSelector: { ($0, $1) })
      .map { (accounts: $0, holderName: $1.name) }
      .map { pair -> [CardPageViewCellViewModel] in
        return pair.accounts.compactMap { [weak self] in
          CardPageViewCellViewModel(
            balance: String($0.balance / 100),
            cardNumber: $0.maskedPan.first ?? "",
            cardTypeImage: self?.getImage(
              for: MoneyConverter.getCardType(from: $0.maskedPan.first ?? "")
            ),
            cardHolderName: pair.holderName,
            currency: MoneyConverter.getCurrencyName(for: $0.currencyCode),
            cardType: $0.type
          )
        }
      }
      .share()
    
    cellModelsObservable
      .observe(on: MainScheduler.asyncInstance)
      .map { $0.count }
      .bind(to: cellModelsCount)
      .disposed(by: bag)
    
    cellModelsObservable
      .observe(on: MainScheduler.asyncInstance)
      .bind(onNext: { [weak self] items in
        self?.cellModels.accept(items)
      })
      .disposed(by: bag)
    
    cellModels
      .asVoid()
      .bind(to: updateCellsEvent)
      .disposed(by: bag)
  }
}


