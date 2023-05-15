//
//  DefaultUI.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - UIView
extension UIView {
  static func createDefaultView() -> UIView {
    let view = UIView()
    view.isOpaque = false
    return view
  }
}

// MARK: - UITextView
extension UITextView {
  static func createDefaultTextView() -> UITextView {
    let textView = UITextView()
    textView.isOpaque = false
    return textView
  }
}

// MARK: - UIButton
extension UIButton {
  static func createDefaultButton() -> UIButton {
    let button = UIButton()
    return button
  }
}

// MARK: - UIStackView
extension UIStackView {
  static func createDefaultStack() -> UIStackView {
    let stackView = UIStackView()
    stackView.isOpaque = false
    return stackView
  }
  
  static func createVerticalStack() -> UIStackView {
    let stackView = UIStackView()
    stackView.isOpaque = false
    stackView.alignment = .leading
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    return stackView
  }
}

// MARK: - UIScrollView
extension UIScrollView {
  static func createDefaultScroll() -> UIScrollView {
    let scrollView = UIScrollView()
    scrollView.isOpaque = false
    return scrollView
  }
}

// MARK: - UILabel
extension UILabel {
  static func createDefaultLabel() -> UILabel {
    let label = UILabel()
    label.isOpaque = false
    return label
  }
}

// MARK: - UITextField
extension UITextField {
  static func createDefaultTF() -> UITextField {
    let textField = UITextField()
    return textField
  }
}

// MARK: - UIImageView
extension UIImageView {
  static func createDefaultIV(withImage image: UIImage? = nil) -> UIImageView {
    let imageView = UIImageView()
    imageView.image = image
//    imageView.isOpaque = false
    return imageView
  }
}

// MARK: - UICollections
extension UICollectionView {
  static func createDefaultCollectionView(
    autoresizing: Bool = false,
    scroll direction:  UICollectionView.ScrollDirection = .horizontal
  ) -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = direction
    if autoresizing {
      layout.itemSize = UICollectionViewFlowLayout.automaticSize
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isOpaque = false
    return collectionView
  }
}

// MARK: - UITableView
extension UITableView {
  static func createDefaultTableView(with style: UITableView.Style = .plain) -> UITableView {
    let tableView = UITableView(frame: .zero, style: style)
    return tableView
  }
}
