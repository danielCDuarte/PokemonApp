//
//  BaseCollectionView.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

enum EnumCollectionFlowDisplay {
    case grid
    case list
}

class BaseCollectionView: UICollectionView {
    
    var flowLayout: CollectionViewFlowLayoutCustom = {
        return CollectionViewFlowLayoutCustom(display: .list)
    }()

    init(frame: CGRect, layout: EnumCollectionFlowDisplay) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        contentInsetAdjustmentBehavior = .always
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setItemHeight(_ height: CGFloat) {
        flowLayout.height = height
    }

    func updateIndex(newdata: [IndexPath]) {
        self.reloadItems(at: newdata)
    }
    
    func setMinimumInteritemSpacing(_ space: CGFloat) {
        flowLayout.minimumInteritemSpacing = space
    }
    
    func setMinimumLineSpacing(_ space: CGFloat) {
        flowLayout.minimumLineSpacing = space
    }
}
