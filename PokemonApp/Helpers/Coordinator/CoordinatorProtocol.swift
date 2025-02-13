//
//  CoordinatorProtocol.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var container: DIContainerProtocol { get }
    func start()
    func finish()
}

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var container: DIContainerProtocol
    
    init(navigationController: UINavigationController,
         container: DIContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        fatalError("Start method must be overridden")
    }
    
    func finish() {
        childCoordinators.removeAll()
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
