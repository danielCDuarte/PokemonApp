//
//  AbilityObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct AbilityDetailObject: Hashable {
    let name: String
    let url: String
}

struct AbilityObject: Hashable {
    let ability: AbilityDetailObject
    let isHidden: Bool
    let slot: Int
}
