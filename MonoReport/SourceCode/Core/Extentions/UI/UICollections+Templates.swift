//
//  UICollections+Templates.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 18.03.2022.
//

import UIKit

// MARK: - Templates

protocol NibCellModel {
    var cellType: NibReusable.Type  { get }
}

protocol NibUITableCellSetupable: UITableViewCell {
    func update(with model: NibCellModel) -> Self
}

  protocol ClassUItableCellSetupable: UITableViewCell {
    func update(with model: ClassCellModel) -> Self
  }

extension UITableView {
    func registerNibCells(cellModels: [NibCellModel]) {
        cellModels.forEach { [weak self] cellModel in
            self?.register(cellModel.cellType.nib, forCellReuseIdentifier: cellModel.cellType.reuseIdentifier)
        }
    }
}

protocol ClassCellModel {
    var cellType: Reusable.Type  { get }
}

protocol ClassCellSetupable: UITableViewCell {
    func update(with model: ClassCellModel) -> Self
}

extension UITableView {
    func registerClassCells(cellModels: [ClassCellModel]) {
        cellModels.forEach { [weak self] cellModel in
            self?.register(cellModel.cellType, forCellReuseIdentifier: cellModel.cellType.reuseIdentifier);
        }
    }
}

protocol ClassCollectionCellSetupable: UICollectionViewCell {
    func update(with model: ClassCellModel) -> Self
}

protocol NibUICollectionCellSetupable: UICollectionViewCell {
    func update(with model: NibCellModel) -> Self
}

extension UICollectionView {
    func registerCells(cellModels: [NibCellModel]) {
        cellModels.forEach { [weak self] cellModel in
            self?.register(cellModel.cellType.nib, forCellWithReuseIdentifier: cellModel.cellType.reuseIdentifier);
        }
    }
}
