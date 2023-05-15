//
//  UIView+Blur.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - Blur
extension UIView {
  func blurBackground() {
    if !UIAccessibility.isReduceTransparencyEnabled {
      backgroundColor = .clear
      let blurEffect = UIBlurEffect(style: .systemMaterial)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = bounds
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      addSubview(blurEffectView)
    } else {
      backgroundColor = .clear
    }
  }
  
  func addBlurGradientBackground(
    colors: [UIColor],
    startPoint start: CGPoint,
    endPoint end: CGPoint,
    cornerRadius: CGFloat = 0) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = start
    gradientLayer.endPoint = end
    gradientLayer.frame = bounds
    gradientLayer.cornerRadius = cornerRadius
    guard !(layer.sublayers?.contains(gradientLayer) ?? false) else { return }
    layer.insertSublayer(gradientLayer, at: 0)
    if !UIAccessibility.isReduceTransparencyEnabled {
      backgroundColor = .clear
      let blurEffect = UIBlurEffect(style: .systemMaterial)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = bounds
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      blurEffectView.layer.cornerRadius = cornerRadius
      insertSubview(blurEffectView, at: 1)
    } else {
      gradientLayer.removeFromSuperlayer()
      backgroundColor = .background
    }
  }
  
  func addGradientBackgroundWith(
    _ colors: [UIColor],
    startPoint start: CGPoint,
    endPoint end: CGPoint,
    cornerRadius: CGFloat = 0
  ) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = start
    gradientLayer.endPoint = end
    gradientLayer.frame = bounds
    gradientLayer.cornerRadius = cornerRadius
    guard !(layer.sublayers?.contains(gradientLayer) ?? false) else { return }
    layer.insertSublayer(gradientLayer, at: 0)
  }
}
