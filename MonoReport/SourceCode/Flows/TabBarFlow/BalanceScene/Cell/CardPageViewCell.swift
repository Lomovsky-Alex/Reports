//
//  CardPageViewCell.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 20.03.2022.
//

import UIKit
import SnapKit
import FSPagerView

// MARK: - ViewModel
struct CardPageViewCellViewModel: FSPagerViewCellViewModel {
  let balance: String
  let cardNumber: String
  let cardTypeImage: UIImage?
  var cardHolderName: String
  let currency: String
  let cardType: CardTypeDTO
}

// MARK: - Cell
final class CardPageViewCell: FSPagerViewCell, FSPagerViewCellSetuppable {
  
  // MARK: - UIElements
  private let balanceLabel = UILabel.createDefaultLabel()
  private let cardNumberLabel = UILabel.createDefaultLabel()
  private let cardTypeImageView = UIImageView.createDefaultIV()
  private let cardHolderLabel = UILabel.createDefaultLabel()
  private let currencyLabel = UILabel.createDefaultLabel()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupConstraints()
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIMethods
  private func setupConstraints() {
    contentView.addSubview(balanceLabel)
    balanceLabel.snp.makeConstraints { make in
      make.top.left.equalToSuperview().offset(LocalConstants.edgeSpacing)
      make.right.lessThanOrEqualTo(contentView.snp.centerX)
    }
    contentView.addSubview(currencyLabel)
    currencyLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(LocalConstants.edgeSpacing)
      make.right.equalToSuperview().offset(-LocalConstants.edgeSpacing)
    }
    contentView.addSubview(cardHolderLabel)
    cardHolderLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(LocalConstants.edgeSpacing)
      make.bottom.equalToSuperview().offset(-LocalConstants.edgeSpacing)
    }
    contentView.addSubview(cardNumberLabel)
    cardNumberLabel.snp.makeConstraints { make in
      make.bottom.equalTo(cardHolderLabel.snp.top).offset(-LocalConstants.labelsSpacing)
      make.left.equalToSuperview().offset(LocalConstants.edgeSpacing)
    }
    contentView.addSubview(cardTypeImageView)
    cardTypeImageView.snp.makeConstraints { make in
      make.right.equalToSuperview().offset(-LocalConstants.labelsSpacing)
      make.bottom.equalToSuperview().offset(-LocalConstants.edgeSpacing)
      make.height.equalTo(LocalConstants.imageViewHeight)
        .constraint.activate()
      make.width.equalTo(LocalConstants.imageViewWidth)
        .constraint.activate()
    }
  }
  
  private func setupViews() {
    contentView.layer.cornerRadius = LocalConstants.cornerRadius
    cardTypeImageView.contentMode = .scaleAspectFill
    balanceLabel.set(font: .Montserrat.medium, size: LocalConstants.baseFontSize)
    currencyLabel.set(font: .Montserrat.medium, size: LocalConstants.baseFontSize)
    cardNumberLabel.set(font: .Montserrat.semiBold, size: LocalConstants.biggerFontSize)
    cardHolderLabel.set(font: .Montserrat.medium, size: LocalConstants.baseFontSize)
  }
  
  // MARK: - ClassCollectionCellSetupable
  func update(with model: FSPagerViewCellViewModel) -> Self {
    guard let model = model as? CardPageViewCellViewModel else { return self }
    cardNumberLabel.setText(model.cardNumber)
    balanceLabel.setText(model.balance)
    cardTypeImageView.image = model.cardTypeImage
    cardHolderLabel.setText(model.cardHolderName)
    currencyLabel.setText(model.currency)
    switch model.cardType {
      case .black:
        contentView.addGradientBackgroundWith(
          [.monoBlackColor, .monoGrayColor],
          startPoint: .ViewPoint.centerBottom,
          endPoint: .ViewPoint.centerTop,
          cornerRadius: LocalConstants.cornerRadius
        )
        balanceLabel.setText(color: .lightGray)
        currencyLabel.setText(color: .lightGray)
        cardNumberLabel.setText(color: .lightGray)
        cardHolderLabel.setText(color: .lightGray)
      default:
        contentView.backgroundColor = .gray
    }
    return self
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let edgeSpacing: CGFloat = 15
  static let cornerRadius: CGFloat = 10
  static let labelsSpacing: CGFloat = 40
  static let imageViewWidth: CGFloat = 45
  static let imageViewHeight: CGFloat = 30
  static let baseFontSize: CGFloat = 15
  static let biggerFontSize: CGFloat = 17
}
