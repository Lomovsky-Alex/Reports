//
//  HalapenjoPageControl+Templates.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import CHIPageControl

extension CHIPageControlAleppo {
  static func createDefaultPageControl() -> CHIPageControlAleppo {
    let control = CHIPageControlAleppo()
    control.translatesAutoresizingMaskIntoConstraints = false
    control.isOpaque = false
    return control
  }
}

