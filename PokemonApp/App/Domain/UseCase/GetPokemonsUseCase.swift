//
//  GetPokemonsUseCase.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class GetPokemonsUseCase: AnyUseCase< PokemonsParamsObject, PokemonsObject> {
    let repository: PokemonRepositoriesType
    
    init(repository: PokemonRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: PokemonsParamsObject) async throws -> PokemonsObject {
        do {
            return try await repository.getPokemons(with: params.offset, limit: params.limit)
        } catch {
            throw error
        }
    }
}
