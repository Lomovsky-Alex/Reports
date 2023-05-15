//
//  SettingsScene.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 24.08.2022.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources

// MARK: - Events
protocol SettingsSceneEvents {
  var bag: DisposeBag { get }
}

// MARK: - Scene
final class SettingsScene: BaseScene, SettingsSceneEvents {
  private let tableView = UITableView.createDefaultTableView()
  
  // MARK: - Lifecycle
  private let viewModel: SettingsSceneViewModelType
  
  init(viewModel: SettingsSceneViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Events
  var bag: DisposeBag {
    return viewModel.bag
  }
  
  // MARK: - UIMethods
  override func setupConstraints() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(view.safeArea.top)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  override func setupViews() {
    super.setupViews()
    navigationController?.isNavigationBarHidden = true
    tableView.delegate = self
    tableView.backgroundColor = view.backgroundColor
    tableView.register(cellType: UserInfoCell.self)
    tableView.separatorStyle = .none
  }
  
  // MARK: - BindEvents
  override func bindEvents() {
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>>(
      configureCell: { dataSource, table, indexPath, item in

        switch item {
          case .userInfoCell(let model):
            let cell: UserInfoCell = table.dequeueReusableCell(for: indexPath)
            cell.buttonPressedEvent
              .bind(to: self.viewModel.input.photoButtonPressedEvent)
              .disposed(by: cell.bag)
            return cell.update(with: model)
        }
      })
    
    viewModel.output.settingsItems
      .asObservable()
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
  }
  
}

extension SettingsScene: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == .zero && indexPath.row == .zero {
      return 100
    } else {
      return UITableView.automaticDimension
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let profileImageMultiplier: CGFloat = 0.8
}
