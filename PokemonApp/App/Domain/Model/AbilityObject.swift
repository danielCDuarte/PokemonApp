//
//  AbilityObject.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct AbilityDetailObject {
    let name: String
    let url: String
}

struct AbilityObject {
    let ability: AbilityDetailObject
    let isHidden: Bool
    let slot: Int
}
