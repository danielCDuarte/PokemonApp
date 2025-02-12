//
//  UIImageView+Extensions.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 12/02/25.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: URL) async throws -> UIImage? {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
    }
}
