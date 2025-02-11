//
//  APIDetailResponse.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct APIDetailResponse: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [APIAbility]
    let stats: [APIStat]
}
