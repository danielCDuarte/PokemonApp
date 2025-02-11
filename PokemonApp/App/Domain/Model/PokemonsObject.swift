//
//  PokemonsObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct PokemonObject {
    let name: String
    let url: String
}

struct PokemonsObject {
    let count: Int
    let next: String
    let results: [PokemonObject]
}
