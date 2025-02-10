//
//  DataConstants.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

import Foundation

struct DataConstants {
    enum APIClient {
        static let contentType: String = "Content-Type"
    }
    
    enum InnerConstants {
        static let applicationJson: String = "application/json"
    }
    struct Image {
        static let getSprite: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%d.png"
        static let getOfficialArtwork: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
    }
    
    static let baseUrl: String = "https://pokeapi.co/api/v2/pokemon/"
}
