//
//  DetailPokemonDI.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

final public class DetailPokemonDI {
    static func inject(_ pokemon: PokemonObject) -> DetailPokemonViewController {
        
        let presenterDependencies = DetailPokemonPresenter.InputDependencies(
            pokemon: pokemon
        )
        let presenter = DetailPokemonPresenter(dependencies: presenterDependencies)
        let DetailPokemonViewController = DetailPokemonViewController()
        DetailPokemonViewController.presenter = presenter
        return DetailPokemonViewController
    }
}
