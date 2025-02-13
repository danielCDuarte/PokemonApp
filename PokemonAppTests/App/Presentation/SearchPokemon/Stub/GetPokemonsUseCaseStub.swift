//
//  GetPokemonsUseCaseStub.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp

class GetPokemonsUseCaseStub: AnyUseCase< PokemonsParamsObject, PokemonsObject> {
    static var error: Error?
    static var response: PokemonsObject!
    
    override func execute(params: PokemonsParamsObject) async throws -> PokemonsObject {
        if let error = GetPokemonsUseCaseStub.error {
            throw error
        }
        return GetPokemonsUseCaseStub.response
    }
}
