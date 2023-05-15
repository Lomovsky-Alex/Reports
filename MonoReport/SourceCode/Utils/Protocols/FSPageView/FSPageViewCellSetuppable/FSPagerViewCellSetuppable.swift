//
//  FSPagerViewCellSetuppable.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 20.03.2022.
//

import Foundation
import FSPagerView

protocol FSPagerViewCellViewModel {}
protocol FSPagerViewCellSetuppable: FSPagerViewCell {
  func update(with model: FSPagerViewCellViewModel) -> Self
}
