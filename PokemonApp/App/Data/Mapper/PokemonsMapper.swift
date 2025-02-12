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
            results: input.results.enumerated().map { index, item in
                getPokemon(index: index + 1, input: item)
            }
        )
    }
    
    private static func getPokemon(index: Int, input: APIPokemon) -> PokemonObject {
        return .init(
            id: index,
            name: input.name,
            url: input.url
        )
    }
}
