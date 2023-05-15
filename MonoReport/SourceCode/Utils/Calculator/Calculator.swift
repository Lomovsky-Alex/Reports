//
//  Calculator.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import Foundation

// MARK: - Calculator
final class Calculator {
  static func calculatePercent(of firstValue: Float, in secondValue: Float) -> Float {
    return firstValue * 100 / secondValue
  }
  
  static func calculateValue(fromPercent percentValue: Float, totalValue value: Float) -> Float {
    return percentValue * value / 100
  }
}
