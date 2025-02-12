//
//  AppCoordinator.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let searchPokemonCoordinator = SearchPokemonCoordinator(navigationController: navigationController)
        addChildCoordinator(searchPokemonCoordinator)
        searchPokemonCoordinator.start()
        
    }
}
