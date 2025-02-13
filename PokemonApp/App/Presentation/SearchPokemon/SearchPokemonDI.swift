//
//  SearchPokemonDI.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation
import UIKit

final public class SearchPokemonDI {
    static func inject(container: DIContainerProtocol) -> SearchPokemonViewController {
        guard let pokemonRepository: PokemonRepositoriesType = container.resolve() else {
            fatalError("Required dependencies not found")
        }
        
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
