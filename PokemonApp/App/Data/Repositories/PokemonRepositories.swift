//
//  PokemonRepositories.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class PokemonRepositories: PokemonRepositoriesType {
    
    private(set) var networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func getPokemons(with offset: Int, limit: Int) async throws -> PokemonsObject {
        let endPoint = NetworkRequest<APIPokemonsResponse>(
            method: .GET,
            relativePath: "",
            parameters: [
                "offset": offset,
                "limit": limit
            ]
        )
        do {
            let data = try await networkService.request(endPoint, queue: .main)
            return PokemonsMapper.map(input: data)
        }
        catch {
            throw error
        }
    }
    
    func getDetails(_ id: Int) async throws -> DetailObject {
        let endPoint = NetworkRequest<APIDetailResponse>(
            method: .GET,
            relativePath: "\(id)",
            parameters: nil
        )
        do {
            let data = try await networkService.request(endPoint, queue: .main)
            return PokemonDetailMapper.map(input: data)
        }
        catch {
            throw error
        }
    }
    
}
