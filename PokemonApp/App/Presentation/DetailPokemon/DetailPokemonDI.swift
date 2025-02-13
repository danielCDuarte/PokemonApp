//
//  DetailPokemonDI.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

final public class DetailPokemonDI {
    static func inject(_ pokemon: PokemonObject, container: DIContainerProtocol) -> DetailPokemonViewController {
        
        guard let pokemonRepository: PokemonRepositoriesType = container.resolve() else {
            fatalError("Required dependencies not found")
        }
        
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
