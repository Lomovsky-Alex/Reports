//
//  ScrollableScene.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

// MARK: - ScrollableScene
class ScrollableScene: BaseScene {
  
  var showScrollIndicator: Bool {
    return true
  }
  
  // MARK: - UIElements
  let scrollView = UIScrollView.createDefaultScroll()
  let contentView = UIView.createDefaultView()
  
  // MARK: - UIMethods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func setupConstraints() {
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(view.snp.top)
      make.bottom.equalToSuperview()
      make.left.equalTo(view.safeArea.left)
      make.right.equalTo(view.safeArea.right)
    }
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
      make.width.equalTo(view.snp.width)
    }
  }
  
  override func setupViews() {
    super.setupViews()
    scrollView.showsVerticalScrollIndicator = showScrollIndicator
  }
}
