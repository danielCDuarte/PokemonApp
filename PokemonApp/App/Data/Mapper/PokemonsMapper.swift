//
//  PokemonsMapper.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct PokemonsMapper: MapperType {
    
    typealias Input = APIPokemonsResponse
    typealias Output = PokemonsObject
    
    static func map(input: APIPokemonsResponse) -> PokemonsObject {
        return .init(
            count: input.count,
            next: input.next,
            results: input.results.map {
                getPokemon(input: $0)
            }
        )
    }
    
    private static func getPokemon(input: APIPokemon) -> PokemonObject {
        return .init(
            name: input.name,
            url: input.url
        )
    }
}
