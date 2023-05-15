//
//  AnimatableButton.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit

// MARK: - AnimatableButton
final class AnimatableButton: UIButton {
    
  static func createAnimatableButton() -> AnimatableButton {
    let button = AnimatableButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    animateAlpha(alpha: 0.5, duration: 0.1, autoreverce: false)
    super.touchesBegan(touches, with: event)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    animateAlpha(alpha: 1, duration: 0.1, autoreverce: false)
    super.touchesEnded(touches, with: event)
  }
}
