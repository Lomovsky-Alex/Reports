//
//  UIView+Animations.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - Animations
extension UIView {
  func hide() {
    isHidden = true
  }
  
  func show() {
    isHidden = false
  }
  
  /// Use this method to hide view with animation
  /// - Parameters:
  ///   - duration: The duration of the animation
  ///   - completion: Completion with Boolean value indicating was the animation completed or not
  /// - Note: This method changes views`s *alpha* property
  func hideAnimated(duration: TimeInterval = 0.1, completion: ItemCompletionBlock<Bool>? = nil) {
    UIView.animate(withDuration: duration) { [weak self] in
      guard let self = self else { return }
      self.alpha = 0
    } completion: { [weak self] animated in
      guard let self = self else { return }
      self.isHidden = true
      completion?(animated)
    }
  }
  
  /// Use this method to show view with animation
  /// - Parameters:
  ///   - duration: The duration of the animation
  ///   - completion: Completion with Boolean value indicating was the animation completed or not
  /// - Note: This method changes views`s *alpha* property
  func showAnimated(duration: TimeInterval = 0.1, completion: ItemCompletionBlock<Bool>? = nil) {
    isHidden = false
    UIView.animate(withDuration: duration) { [weak self] in
      guard let self = self else { return }
      self.alpha = 1
    } completion: { animated in
      completion?(animated)
    }
  }
  
  /// Use this method to animate a view disapearing
  /// - Parameters:
  ///   - alpha: Alpha to be applied
  ///   - duration: Duration of the animation
  ///   - Note: Duration doubles if autoreverce is true
  ///   - autoreverce: Should alpha return to previous state
  func animateAlpha(alpha: CGFloat, duration: TimeInterval, autoreverce: Bool = true) {
    let oldAlpha = self.alpha
    UIView.animate(withDuration: duration) {
      self.alpha = alpha
    } completion: { _ in
      if autoreverce {
        UIView.animate(withDuration: duration) {
          self.alpha = oldAlpha
        }
      }
    }
  }
}

