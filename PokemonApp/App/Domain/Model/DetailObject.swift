//
//  DetailObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct InfoDetailObject: Hashable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
}

struct DetailObject: Hashable {
    let info :InfoDetailObject
    let abilities: [AbilityObject]
    let stats: [StatObject]
}
