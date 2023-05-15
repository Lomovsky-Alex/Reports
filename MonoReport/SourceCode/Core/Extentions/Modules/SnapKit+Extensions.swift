//
//  SnapKit+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 24.08.2022.
//

import UIKit
import SnapKit

extension UIView {
  var safeArea:  ConstraintLayoutGuideDSL {
    return self.safeAreaLayoutGuide.snp
  }
}
