//
//  GetDetailUseCaseStub.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp

class GetDetailUseCaseStub: AnyUseCase< Int, DetailObject> {
    static var error: Error?
    static var response: DetailObject!
    
    override func execute(params: Int) async throws -> DetailObject {
        if let error = GetDetailUseCaseStub.error {
            throw error
        }
        return GetDetailUseCaseStub.response
    }
}
