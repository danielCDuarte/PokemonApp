//
//  SearchPokemonDI.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation
import UIKit

final public class SearchPokemonDI {
    static func inject() -> SearchPokemonViewController {
        //Data
        let networkService = NetworkService(
            url: DataConstants.baseUrl,
            urlSession: URLSession.shared,
            decoder: JSONDecoder()
        )
        
        let pokemonRepository = PokemonRepositories(networkService: networkService)
        
        //Domain
        let getPokemonsUseCase = GetPokemonsUseCase(repository: pokemonRepository)
        
        //Presentation
        let presenterDependencies = SearchPokemonPresenter.InputDependencies(
            getPokemonsUseCase: getPokemonsUseCase
        )
        let presenter = SearchPokemonPresenter(dependencies: presenterDependencies)
        let SearchPokemonViewController = SearchPokemonViewController()
        SearchPokemonViewController.presenter = presenter
        return SearchPokemonViewController
    }
}
