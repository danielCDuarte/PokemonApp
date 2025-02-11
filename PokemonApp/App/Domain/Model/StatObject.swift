//
//  StatObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct APIStatDetailObject {
    let name: String
    let url: String
}

struct StatObject {
    let stat: APIStatDetailObject
    let baseStat: Int
    let effort: Int
}
