//
//  StatObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct APIStatDetailObject: Hashable{
    let name: String
    let url: String
}

struct StatObject: Hashable {
    let stat: APIStatDetailObject
    let baseStat: Int
    let effort: Int
}
