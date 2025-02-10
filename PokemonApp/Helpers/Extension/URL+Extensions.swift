//
//  URL+Extensions.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

import Foundation

extension URL {
    static func getUrl(from string: String?) -> URL? {
        return URL(string: string ?? "")
    }
}
