//
//  FirstOnboardingView.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import SnapKit

final class OnboardingView: UIView {
  
  // MARK: - UIElements
  let imageView = UIImageView.createDefaultIV(withImage: .calendar)
  let titleLabel = UILabel.createDefaultLabel()
  let subtitleLabel = UILabel.createDefaultLabel()
  
  // MARK: - Lifecycle
  init(image: UIImage?, title: String, subtitle: String) {
    imageView.image = image
    titleLabel.setText(title)
    subtitleLabel.setText(subtitle)
    super.init(frame: .zero)
    
    setupConstraints()
    configureSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.setNeedsLayout()
    imageView.layoutIfNeeded()
    imageView.makeCircle()
  }
  
  static func createOnboardingView(
    image: UIImage?,
    title: String,
    subtitle: String
  ) -> OnboardingView {
    let view = OnboardingView(image: image, title: title, subtitle: subtitle)
    view.isOpaque = false
    return view
  }
  
  // MARK: - UIMethods
  private func setupConstraints() {
    addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
      make.height.width.equalTo(snp.width).multipliedBy(LocalConstants.imageViewSizeMultiplier)
    }
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(LocalConstants.elementsSpacing)
      make.centerX.equalToSuperview()
      make.left.equalToSuperview().offset(LocalConstants.elementsSpacing)
      make.right.equalToSuperview().offset(-LocalConstants.elementsSpacing)
    }
    addSubview(subtitleLabel)
    subtitleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(LocalConstants.labelsSpacing)
      make.left.equalToSuperview().offset(LocalConstants.elementsSpacing)
      make.bottom.lessThanOrEqualToSuperview()
    }
  }
  
  private func configureSubviews() {
    backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .background
    titleLabel.set(font: .Montserrat.medium, size: LocalConstants.titleFontSize)
    titleLabel.setText(aligment: .center)
    subtitleLabel.numberOfLines = .zero
    subtitleLabel.set(font: .Montserrat.regular, size: LocalConstants.subtitleFontSize)
    subtitleLabel.setText(aligment: .center)
  }
}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
  static let imageViewSizeMultiplier: CGFloat = 0.55
  static let elementsSpacing: CGFloat = 30
  static let labelsSpacing: CGFloat = 10
  static let titleFontSize: CGFloat = 25
  static let subtitleFontSize: CGFloat = 17
}
