//
//  SettingsSceneViewModel.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 24.08.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

// MARK: - CellModel
enum CellModel {
  case userInfoCell(ClassCellModel)
}

// MARK: - Protocols
protocol SettingsSceneViewModelInput {
  var photoButtonPressedEvent: BehaviorEvent { get }
  var selectedItem: AnyObserver<IndexPath> { get }
  var switcherChanged: AnyObserver<IndexPath> { get }
}

protocol SettingsSceneViewModelOutput {
  var settingsItems: Driver<[SectionModel<String, CellModel>]> { get }
}

protocol SettingsSceneViewModelType {
  var input: SettingsSceneViewModelInput { get }
  var output: SettingsSceneViewModelOutput { get }
  var bag: DisposeBag { get }
}

// MARK: - ViewModel
final class SettingsSceneViewModel:
  SettingsSceneViewModelInput,
  SettingsSceneViewModelOutput,
  SettingsSceneViewModelType
{
  
  // MARK: - Lifecycle
  init() {
    bindEvents()
  }
  
  // MARK: - Input
  let photoButtonPressedEvent = BehaviorEvent()
  private let selectedItemSubject = PublishSubject<IndexPath>()
  var selectedItem: AnyObserver<IndexPath> {
    return selectedItemSubject
      .asObserver()
  }
  private let switcherChangedSubject = PublishSubject<IndexPath>()
  var switcherChanged: AnyObserver<IndexPath> {
    return switcherChangedSubject
      .asObserver()
  }
  
  // MARK: - Type
  var input: SettingsSceneViewModelInput { return self }
  var output: SettingsSceneViewModelOutput { return self }
  let bag = DisposeBag()
  
  // MARK: - Output
  private let settingsItemsSubject = BehaviorSubject<[SectionModel<String, CellModel>]>([])
  var settingsItems: Driver<[SectionModel<String, CellModel>]> {
    return settingsItemsSubject
      .asDriver(onErrorJustReturn: [])
  }
  
  // MARK: - Private
  private func bindEvents() {
    settingsItemsSubject.onNext([
      SectionModel(model: "", items: [
        CellModel.userInfoCell(UserInfoCellViewModel(greetingsText: "Good evening, Oleksandr", profilePhotoImage: .hand))
      ])
    ])
    
    photoButtonPressedEvent
      .bind { _ in
        Log.d("Button pressed")
      }
      .disposed(by: bag)
  }
}
