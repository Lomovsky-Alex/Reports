//
//  SwitcherCell.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 09.09.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

// MARK: - ViewModel
struct SettingsCellViewModel: ClassCellModel {
  var cellType: Reusable.Type = SwitcherCell.self
  let title: String
  let isOn: Bool
}

// MARK: - Cell
final class SwitcherCell: UITableViewCell, Reusable, ClassCellSetupable {
  
  // MARK: - UIElements
  private let label = UILabel.createDefaultLabel()
  private let switchControl = UISwitch()
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: SwitcherCell.reuseIdentifier)
    setupConstraints()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - ClassCellSetupable
  func update(with model: ClassCellModel) -> Self {
    guard let model = model as? SettingsCellViewModel else { return self }
    label.setText(model.title)
    switchControl.isOn = model.isOn
    return self
  }
  
  // MARK: - UIMethods
  private func setupConstraints() {
    contentView.addSubview(label)
    label.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.left.equalToSuperview().offset(LocalConstants.edgeSpacing)
    }
    contentView.addSubview(switchControl)
    switchControl.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().offset(-LocalConstants.edgeSpacing)
    }
    label.snp.makeConstraints { make in
      make.trailing.lessThanOrEqualTo(switchControl).offset(LocalConstants.elementsSpacing)
    }
  }
  
  private func setupUI() {
    switchControl.onTintColor = .orange
  }
}


// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let edgeSpacing: CGFloat = 30
  static let elementsSpacing: CGFloat = 5
}
