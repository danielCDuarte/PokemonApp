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
}
