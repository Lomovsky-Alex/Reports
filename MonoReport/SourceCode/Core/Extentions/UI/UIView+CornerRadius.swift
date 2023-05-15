//
//  UIView+CornerRadius.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - CornerRadius

extension UIView {
  
  func roundCorners(corners: UIRectCorner, radius: CGFloat, customRect: CGRect? = nil) {
    let path = UIBezierPath(
      roundedRect: customRect ?? bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  func makeCircle() {
    clipsToBounds = true
    layer.cornerRadius = frame.size.height / 2
  }
  
  func makeCorners(
    radius: CGFloat,
    maskedCorners: CACornerMask =  [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
  ) {
    layer.cornerRadius = radius
    layer.maskedCorners = maskedCorners
    clipsToBounds = true
  }
}
