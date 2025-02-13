//
//  AppCoordinator.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    let window: UIWindow
    init(window: UIWindow, navigationController: UINavigationController, container: DIContainerProtocol) {
        self.window = window
        super.init(navigationController: navigationController, container: container)
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let searchPokemonCoordinator = SearchPokemonCoordinator(navigationController: navigationController, container: container)
        addChildCoordinator(searchPokemonCoordinator)
        searchPokemonCoordinator.start()
        
    }
}
