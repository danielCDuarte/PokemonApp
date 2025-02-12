//
//  SearchPokemonCoordinator.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class SearchPokemonCoordinator: BaseCoordinator {
    override func start() {
        let SearchCharacterViewController = SearchPokemonDI.inject()
        SearchCharacterViewController.coordinator = self
        navigationController.pushViewController(SearchCharacterViewController, animated: true)
    }
    
    func pushDetail(_ item: PokemonObject) {
        let detailPokemonViewController = DetailPokemonDI.inject(item)
        navigationController.pushViewController(detailPokemonViewController, animated: true)
    }
}
