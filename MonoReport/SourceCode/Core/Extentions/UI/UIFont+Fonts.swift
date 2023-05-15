//
//  UIFont+Fonts.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

extension UIFont {
  enum Montserrat {
    static var bold: UIFont {
      return UIFont(name: "Montserrat-Bold", size: UIFont.labelFontSize) ??
        .systemFont(ofSize: UIFont.labelFontSize)
    }
    static var medium: UIFont {
      return UIFont(name: "Montserrat-Medium", size: UIFont.labelFontSize) ??
        .systemFont(ofSize: UIFont.labelFontSize)
    }
    static var regular: UIFont {
      return UIFont(name: "Montserrat-Regular", size: UIFont.labelFontSize) ??
        .systemFont(ofSize: UIFont.labelFontSize)
    }
    static var semiBold: UIFont {
      return UIFont(name: "Montserrat-SemiBold", size: UIFont.labelFontSize) ??
        .systemFont(ofSize: UIFont.labelFontSize)
    }
    static var alternatesBold: UIFont {
      return UIFont(name: "MontserratAlternates-Bold", size: UIFont.labelFontSize) ??
        .systemFont(ofSize: UIFont.labelFontSize)
    }
    static var alternatesSemiBold: UIFont {
      return UIFont(name: "MontserratAlternates-SemiBold", size: UIFont.labelFontSize) ??
        .systemFont(ofSize: UIFont.labelFontSize)
    }
  }
}
