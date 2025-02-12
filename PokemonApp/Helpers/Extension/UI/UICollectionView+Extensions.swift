//
//  UICollectionView+Extensions.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }
    
    func register(_ cellClass: AnyClass?, forSupplementaryViewOfKind: String) {
        guard let className = cellClass else {
            fatalError("Couldn't find forSupplementaryViewOfKind for \(String(describing: forSupplementaryViewOfKind))")
        }
        register(cellClass,
            forSupplementaryViewOfKind: forSupplementaryViewOfKind,
            withReuseIdentifier: String(describing: className.self))
    }
    
    func dequeueReusableHeaderFooterView<T: UICollectionReusableView>(kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let headerFooterView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name))")
        }
        return headerFooterView
    }
}
