//
//  UIDevice+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - ScreenType

extension UIDevice {
  var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
  var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
  var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
  }
  
  var isSmall: Bool {
    return UIScreen.main.bounds.size.height <= 568
  }
  
  var hasNotch: Bool {
      guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
      if UIDevice.current.orientation.isPortrait {
          return window.safeAreaInsets.top >= 44
      } else {
          return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
      }
  }
}
