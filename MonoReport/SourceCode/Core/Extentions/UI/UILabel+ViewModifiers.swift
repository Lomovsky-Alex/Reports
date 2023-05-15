//
//  UILabel+ViewModifiers.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

extension UILabel {
  func set(font newFont: UIFont, size: CGFloat) {
    font = newFont.withSize(size)
  }
  
  func setText(color uicolor: UIColor) {
    textColor = uicolor
  }
  
  func setText(aligment anAligment: NSTextAlignment) {
    textAlignment = anAligment
  }
  
  func setText(_ string: String) {
    text = string
  }
}

