//
//  FSPageControl+Extensions.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 20.03.2022.
//

import UIKit
import FSPagerView

extension FSPagerViewCell: Reusable {}

extension FSPagerView {  
  func register<T: FSPagerViewCell>(_ cellType: T.Type) {
    register(T.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }
}

extension FSPagerView {
  static func makeCardPageView() -> FSPagerView {
    let view = FSPagerView()
    view.transformer = FSPagerViewTransformer(type: .overlap)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isOpaque = false
    return view
  }
}
