//
//  CGPoint+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 22.09.2022.
//

import CoreGraphics

extension CGPoint {
  enum ViewPoint {
    static let topLeft = CGPoint(x: 0, y: 0)
    static let topRight = CGPoint(x: 1, y: 0)
    static let bottomLeft = CGPoint(x: 0, y: 1)
    static let bottomRight = CGPoint(x: 1, y: 1)
    static let centerTop = CGPoint(x: 0.5, y: 0)
    static let centerBottom = CGPoint(x: 0.5, y: 1)
  }
}
