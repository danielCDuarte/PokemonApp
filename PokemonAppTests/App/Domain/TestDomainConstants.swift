//
//  TestDomainConstants.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation
@testable import PokemonApp

struct TestDomainConstants {
    
    static let pokemon: PokemonObject = {
        .init(
            id: 1,
            name: "bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/"
        )
    }()
    
    static let pokemons: PokemonsObject = {
        .init(
            count: 1,
            next: "https://pokeapi.co/api/v2/pokemon/?offset=151&limit=151",
            results: [
                .init(
                    id: 1,
                    name: "bulbasaur",
                    url: "https://pokeapi.co/api/v2/pokemon/1/"
                ),
                .init(
                    id: 2,
                    name: "ivysaur",
                    url: "https://pokeapi.co/api/v2/pokemon/2/"
                ),
                .init(
                    id: 3,
                    name: "venusaur",
                    url: "https://pokeapi.co/api/v2/pokemon/3/"
                ),
                .init(
                    id: 4,
                    name: "charmander",
                    url: "https://pokeapi.co/api/v2/pokemon/4/"
                ),
                .init(
                    id: 5,
                    name: "charmeleon",
                    url: "https://pokeapi.co/api/v2/pokemon/5/"
                )
            ])
    }()
    
    static let detail: DetailObject = {
        .init(
            info: .init(
                id: 1,
                name: "bulbasaur",
                height: 7,
                weight: 69
            ),
            abilities: [
                .init(
                    ability: .init(
                        name: "overgrow",
                        url: "https://pokeapi.co/api/v2/ability/65/"
                    ),
                    isHidden: false,
                    slot: 1
                )
            ],
            stats: [
                .init(
                    stat: .init(
                        name: "hp",
                        url: "https://pokeapi.co/api/v2/stat/1/"
                    ),
                    baseStat: 45,
                    effort: 0
                )
            ]
        )
    }()
    
}
