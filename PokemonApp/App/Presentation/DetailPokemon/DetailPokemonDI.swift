//
//  DetailPokemonDI.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

final public class DetailPokemonDI {
    static func inject(_ pokemon: PokemonObject) -> DetailPokemonViewController {
        //Data
        let networkService = NetworkService(
            url: DataConstants.baseUrl,
            urlSession: URLSession.shared,
            decoder: JSONDecoder()
        )
        let pokemonRepository = PokemonRepositories(networkService: networkService)
        
        //Domain
        let getDetailUseCase = GetDetailUseCase(repository: pokemonRepository)
        
        //Presentation
        let presenterDependencies = DetailPokemonPresenter.InputDependencies(
            pokemon: pokemon,
            getDetailUseCase: getDetailUseCase
        )
        let presenter = DetailPokemonPresenter(dependencies: presenterDependencies)
        let DetailPokemonViewController = DetailPokemonViewController()
        DetailPokemonViewController.presenter = presenter
        return DetailPokemonViewController
    }
}
