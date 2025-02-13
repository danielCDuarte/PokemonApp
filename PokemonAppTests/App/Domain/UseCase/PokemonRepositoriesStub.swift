//
//  PokemonRepositoriesStub.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation
@testable import PokemonApp

final class PokemonRepositoriesStub {
    static var error: Error?
    static var responsePokemons: PokemonsObject!
    static var reponseDetail: DetailObject!
}

extension PokemonRepositoriesStub: PokemonRepositoriesType {
    
    func getPokemons(with offset: Int, limit: Int) async throws -> PokemonsObject {
        let data = PokemonRepositoriesStub.responsePokemons
        if let error = PokemonRepositoriesStub.error {
            throw error
        }
        return data!
    }
    
    func getDetails(_ id: Int) async throws -> DetailObject {
        let data = PokemonRepositoriesStub.reponseDetail
        if let error = PokemonRepositoriesStub.error {
            throw error
        }
        return data!
    }
}

