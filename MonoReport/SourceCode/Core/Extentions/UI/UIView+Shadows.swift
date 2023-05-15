//
//  UIView+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - Shadows

extension UIView {
  func addShadowWith(radius: CGFloat, opacity: Float, color: UIColor, shadowOffSet: CGSize = .zero) {
    layer.shadowColor = color.cgColor
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
    layer.shadowOffset = shadowOffSet
    layer.masksToBounds = false
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.rasterizationScale = UIScreen.main.scale
    layer.shouldRasterize = true
  }
}
