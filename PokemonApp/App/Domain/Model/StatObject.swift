//
//  StatObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct StatDetailObject: Hashable {
    let name: String
    let url: String
}

struct StatObject: Hashable {
    let stat: StatDetailObject
    let baseStat: Int
    let effort: Int
}
