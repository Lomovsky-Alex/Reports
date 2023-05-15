//
//  Loader.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import MBProgressHUD

struct BlurredLoader {
  private static let loaderView = UIView(frame: UIScreen.main.bounds)
  
  static func show() {
    loaderView.alpha = 0
    loaderView.blurBackground()
    UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first?
            .addSubview(loaderView)
    
    UIView.animate(withDuration: 0.2) {
      self.loaderView.alpha = 1
    } completion: { _ in
      MBProgressHUD.showAdded(to: loaderView, animated: true)
    }
  }
  
  static func hide() {
    MBProgressHUD.hide(for: loaderView, animated: true)
    UIView.animate(withDuration: 0.2) {
      self.loaderView.alpha = 0
    } completion: { _ in
      self.loaderView.removeFromSuperview()
    }
  }
}
