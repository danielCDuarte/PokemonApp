//
//  SearchPokemonCoordinator.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class SearchPokemonCoordinator: BaseCoordinator {
    
    private func setupDependencies() {
        guard let networkService: NetworkServiceType = container.resolve() else {
            fatalError("Required dependencies not found")
        }
        container.register(type: PokemonRepositoriesType.self, component: PokemonRepositories(networkService: networkService))
    }
    
    override func start() {
        setupDependencies()
        let SearchCharacterViewController = SearchPokemonDI.inject(container: container)
        SearchCharacterViewController.coordinator = self
        navigationController.pushViewController(SearchCharacterViewController, animated: true)
    }
    
    func pushDetail(_ item: PokemonObject) {
        let detailPokemonViewController = DetailPokemonDI.inject(item, container: container)
        navigationController.pushViewController(detailPokemonViewController, animated: true)
    }
}
