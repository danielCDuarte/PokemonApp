//
//  APIStat.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

struct APIStatDetail: Codable {
    let name: String
    let url: String
}

struct APIStat: Codable {
    let stat: APIStatDetail
    let baseStat: Int
    let effort: Int
    
    private enum CodingKeys: String, CodingKey {
        case stat, baseStat = "base_stat", effort
    }
}
