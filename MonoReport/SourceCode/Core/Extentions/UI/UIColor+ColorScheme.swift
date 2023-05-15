//
//  UIColor+ColorScheme.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit

extension UIColor {
  static var background: UIColor {
    UIColor { traitCollection in
      switch traitCollection.userInterfaceStyle {
        case .dark:
          return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
        default:
          return .white
      }
    }
  }
  
  static var orange: UIColor {
    UIColor { traitCollection in
      switch traitCollection.userInterfaceStyle {
        case .dark:
          return UIColor(red: 0.79, green: 0.27, blue: 0.27, alpha: 1.00)
        default:
          return UIColor(red: 0.99, green: 0.33, blue: 0.34, alpha: 1.00)
      }
    }
  }
  
  static let cloudGray = UIColor(red: 0.49, green: 0.49, blue: 0.50, alpha: 1.00)
  static let lightGray = UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.00)
  
  static let monoOrangeColor = UIColor(red: 0.83, green: 0.28, blue: 0.25, alpha: 1.00)
  static let monoYellowColor = UIColor(red: 0.93, green: 0.75, blue: 0.55, alpha: 1.00)
  static let monoPurpleColor = UIColor(red: 0.33, green: 0.39, blue: 0.81, alpha: 1.00)
  static let monoPeachColor = UIColor(red: 0.75, green: 0.61, blue: 0.67, alpha: 1.00)
  static let monoGrayColor = UIColor(red: 0.26, green: 0.27, blue: 0.30, alpha: 1.00)
  static let monoBlackColor = UIColor(red: 0.11, green: 0.11, blue: 0.13, alpha: 1.00)
}
