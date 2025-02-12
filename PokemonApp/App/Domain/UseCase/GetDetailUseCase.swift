//
//  GetDetailUseCase.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class GetDetailUseCase: AnyUseCase< Int, DetailObject> {
    let repository: PokemonRepositoriesType
    
    init(repository: PokemonRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: Int) async throws -> DetailObject {
        do {
            return try await repository.getDetails(params)
        } catch {
            throw error
        }
    }
}
