//
//  APIPokemonsResponse.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

import Foundation

struct APIPokemon: Codable {
    let name: String
    let url: String
}

struct APIPokemonsResponse: Codable {
    let count: Int
    let next: String
    let results: [APIPokemon]
}
