//
//  APIAbility.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct APIAbilityDetail: Codable {
    let name: String
    let url: String
}

struct APIAbility: Codable {
    let ability: APIAbilityDetail
    let isHidden: Bool
    let slot: Int
    
    private enum CodingKeys: String, CodingKey {
        case ability, isHidden = "is_hidden", slot
    }
}
