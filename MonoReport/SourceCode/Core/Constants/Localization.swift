//
//  Localization.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import Foundation

public enum Localization {
  
  // MARK: - Onboarding
    
// May be replaced using RString or other codeGen framework
  enum Onboarding {
    static let calendarSummary = "Onboarding.calendarSummary"
    static let calendarSummaryDescription = "Onboarding.calendarSummary.description"
    static let limits = "Onboarding.limits"
    static let limitsDescription = "Onboarding.limits.description"
    static let convenience = "Onboarding.convenience"
    static let convenienceDescription = "Onboarding.convenience.description"
    static let login = "Onboarding.login"
  }
  
  // MARK: - Actions
  enum Actions {
    static let continueAction = "Actions.continue"
    static let cancelAction = "Actions.cancel"
  }
  
  // MARK: - Error
  enum Error {
    static let error = "Error.error"
    static let serverError = "Error.serverError"
  }
  
  // MARK: - TabBar
  enum TabBar {
    static let balance = "Tabbar.item.balance"
    static let settings = "Tabbar.item.settings"
  }
}
