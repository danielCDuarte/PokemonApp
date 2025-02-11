//
//  GetDetailUseCase.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class GetDetailUseCase: AnyUseCase< String, DetailObject> {
    let repository: PokemonRepositoriesType
    
    init(repository: PokemonRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: String) async throws -> DetailObject {
        do {
            return try await repository.getDetails(params)
        } catch {
            throw error
        }
    }
}
