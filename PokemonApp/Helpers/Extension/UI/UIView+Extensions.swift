//
//  UIView+Extensions.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

extension UIView {
    func setShadow(opacity: Float, offset: CGSize, radius: CGFloat, color: CGColor?, masksToBounds: Bool = false) {
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowColor = color
        layer.masksToBounds = masksToBounds
    }
    
}
