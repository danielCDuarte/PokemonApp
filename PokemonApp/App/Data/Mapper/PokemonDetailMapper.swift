//
//  PokemonDetailMapper.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct PokemonDetailMapper: MapperType {
    
    typealias Input = APIDetailResponse
    typealias Output = DetailObject
    
    static func map(input: APIDetailResponse) -> DetailObject {
        return .init(
            info: .init(
                id: input.id,
                name: input.name,
                height: input.height,
                weight: input.weight
            ),
            abilities: input.abilities.map {
                getAbility(input: $0)
            },
            stats: input.stats.map {
                getStat(input: $0)
            }
        )
    }
    
    private static func getAbility(input: APIAbility) -> AbilityObject {
        return .init(
            ability: .init(
                name: input.ability.name,
                url: input.ability.url
            ),
            isHidden: input.isHidden,
            slot: input.slot
        )
    }
    
    private static func getStat(input: APIStat) -> StatObject {
        return .init(
            stat: .init(
                name: input.stat.name,
                url: input.stat.url
            ),
            baseStat: input.baseStat,
            effort: input.effort
        )
    }
}
