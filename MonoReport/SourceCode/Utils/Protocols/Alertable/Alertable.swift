//
//  Alertable.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit

// MARK: - Alertable
protocol Alertable {
  func makeAlert(title: String?, message: String?, style: UIAlertController.Style, shouldPopModule: Bool)
  func makeSuccessAlert(title: String?, message: String?, shouldPopModule: Bool)
  func makeSystemAPIAccessAlert(title: String?, message: String?, style: UIAlertController.Style)
}

// MARK: - Alertable + Coordinatable
extension Alertable where Self: Coordinatable {
  func makeAlert(
    title: String?,
    message: String? = nil,
    style: UIAlertController.Style,
    shouldPopModule: Bool = false
  ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    let cancelButton = UIAlertAction(
      title: Localization.Actions.cancelAction.localized(),
      style: .cancel) { [weak self] _ in
        guard let self = self else { return }
        if shouldPopModule {
          self.router.popModule()
        } else {
          self.router.dismissModule()
        }
      }
    alert.addAction(cancelButton)
    router.present(alert, animated: true)
  }
  
  func makeSuccessAlert(title: String?, message: String? = nil, shouldPopModule: Bool = false) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelButton = UIAlertAction(
      title: Localization.Actions.continueAction.localized(),
      style: .cancel) { [weak self] _ in
        guard let self = self else { return }
        if shouldPopModule {
          self.router.popModule()
        } else {
          self.router.dismissModule()
        }
      }
    alert.addAction(cancelButton)
    router.present(alert, animated: true)
  }
  
//  func makeSystemAPIAccessAlert(title: String?, message: String?, style: UIAlertController.Style) {
//    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
//    guard UIApplication.shared.canOpenURL(settingsUrl) else { return }
//    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
//    
//    let goToSettingsButton = UIAlertAction(
//      title: Localization.Actions.openSettings.localized(),
//      style: .default) { _ in
//        UIApplication.shared.open(settingsUrl)
//      }
//    
//    let dismissButton = UIAlertAction(
//      title: Localization.Actions.cancel.localized(),
//      style: .cancel) { [unowned self] _ in
//        self.router.popModule()
//      }
//    
//    alert.addAction(dismissButton)
//    alert.addAction(goToSettingsButton)
//    router.present(alert, animated: true)
//  }
}
