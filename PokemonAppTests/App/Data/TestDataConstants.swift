//
//  TestDataConstants.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

import Foundation
@testable import PokemonApp

struct TestDataConstants {
    static let pokemonsResponse: APIPokemonsResponse = {
        .init(
            count: 1,
            next: "https://pokeapi.co/api/v2/pokemon/?offset=151&limit=151",
            results: [
                .init(
                    name: "bulbasaur",
                    url: "https://pokeapi.co/api/v2/pokemon/1/"
                ),
                .init(
                    name: "ivysaur",
                    url: "https://pokeapi.co/api/v2/pokemon/2/"
                ),
                .init(
                    name: "venusaur",
                    url: "https://pokeapi.co/api/v2/pokemon/3/"
                ),
                .init(
                    name: "charmander",
                    url: "https://pokeapi.co/api/v2/pokemon/4/"
                ),
                .init(
                    name: "charmeleon",
                    url: "https://pokeapi.co/api/v2/pokemon/5/"
                )
            ])
    }()
}
