//
//  PokemonRepositoriesType.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

protocol PokemonRepositoriesType {
    func getPokemons(with offset: Int, limit: Int) async throws  -> PokemonsObject
    func getDetails(_ id: Int)  async throws  -> DetailObject
}
