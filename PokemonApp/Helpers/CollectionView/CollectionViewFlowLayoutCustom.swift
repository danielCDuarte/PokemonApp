//
//  CollectionViewFlowLayoutCustom.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

final class CollectionViewFlowLayoutCustom: UICollectionViewFlowLayout {
    
    private var display: EnumCollectionFlowDisplay = .grid {
        didSet{
            configLayout()
        }
    }
    
    var height: CGFloat? {
        didSet {
            configLayout()
        }
    }

    init(display: EnumCollectionFlowDisplay) {
        super.init()
        self.display = display
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupMinimumLineSpacing(minimumLineSpacing: CGFloat) {
        self.minimumLineSpacing = minimumLineSpacing
    }

    func setupMinimumInteritemSpacing(minimumInteritemSpacing: CGFloat) {
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }

    private func configLayout() {
        switch display {
        case .grid:
            scrollDirection = .vertical
            if let collectionView = collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                itemSize = CGSize(width: optimisedWidth, height: optimisedWidth)
            }
        case .list:
            scrollDirection = .vertical
            if let collectionView = collectionView, let height = self.height {
                itemSize = CGSize(width: collectionView.frame.width, height: height)
            } else {
                estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
         let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
         layoutAttributesObjects?.forEach({ layoutAttributes in
             if layoutAttributes.representedElementCategory == .cell  {
                 if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                     layoutAttributes.frame = newFrame
                 }
             }
         })
         return layoutAttributesObjects
     }

     override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
         guard let collectionView = collectionView else {
             fatalError()
         }
         guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
             return nil
         }
         layoutAttributes.frame.origin.x = sectionInset.left
         layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
         return layoutAttributes
     }
}
