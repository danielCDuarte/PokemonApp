//
//  NetworkServiceType.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

import Foundation

protocol NetworkServiceType {
    func setBaseUrl(_ baseUrl: String)
        
    func request<Response>(
        _ endpoint: NetworkRequest<Response>,
        queue: DispatchQueue) async throws -> Response where Response: Decodable
}
