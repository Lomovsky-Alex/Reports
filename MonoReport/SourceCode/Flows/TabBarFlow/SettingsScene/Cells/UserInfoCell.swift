//
//  UserInfoCell.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 01.10.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

// MARK: - ViewModel
struct UserInfoCellViewModel: ClassCellModel {
  var cellType: Reusable.Type = UserInfoCell.self
  let greetingsText: String
  let profilePhotoImage: UIImage?
}

class UserInfoCell: UITableViewCell, Reusable, ClassCellSetupable {
  
  
  // MARK: - UIElements
  private let profilePhotoButton = UIButton.createDefaultButton()
  private let helloLabel = UILabel.createDefaultLabel()

  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: UserInfoCell.reuseIdentifier)
    setupUI()
    bindEvents()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    profilePhotoButton.makeCircle()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    bag = DisposeBag()
  }
  
  // MARK: - Events
  let buttonPressedEvent = BehaviorEvent()
  var bag = DisposeBag()
  
  // MARK: - ClassCellSetupable
  func update(with model: ClassCellModel) -> Self {
    guard let model = model as? UserInfoCellViewModel else { return self }
    profilePhotoButton.setImage(model.profilePhotoImage, for: .normal)
    profilePhotoButton.imageView?.contentMode = .scaleAspectFill
    helloLabel.setText(model.greetingsText)
    setupConstraints()
    return self
  }
  
  // MARK: - UIMethods
  private func setupConstraints() {
    contentView.addSubview(profilePhotoButton)
    profilePhotoButton.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(LocalConstants.edgeSpacing)
      make.centerY.equalToSuperview()
      make.height.equalTo(LocalConstants.buttonHeight)
      make.width.equalTo(LocalConstants.buttonHeight)
    }
    contentView.addSubview(helloLabel)
    helloLabel.snp.makeConstraints { make in
      make.top.lessThanOrEqualToSuperview().offset(LocalConstants.elementsSpacing).priority(.high)
      make.bottom.lessThanOrEqualToSuperview().offset(-LocalConstants.elementsSpacing).priority(.high)
      make.centerY.equalToSuperview().priority(.medium)
      make.left.equalTo(profilePhotoButton.snp.right).offset(LocalConstants.elementsSpacing)
      make.right.equalToSuperview().offset(-LocalConstants.edgeSpacing)
    }
  }
  
  private func setupUI() {
    helloLabel.set(font: .Montserrat.semiBold, size: 30)
    helloLabel.numberOfLines = .zero
  }
  
  private func bindEvents() {
    profilePhotoButton.rx
      .tap
      .bind(to: buttonPressedEvent)
      .disposed(by: bag)
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let edgeSpacing: CGFloat = 30
  static let elementsSpacing: CGFloat = 5
  static let buttonHeight: CGFloat = 100
}
