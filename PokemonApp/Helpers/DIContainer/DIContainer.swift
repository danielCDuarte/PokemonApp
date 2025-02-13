//
//  DIContainer.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import Foundation

protocol DIContainerProtocol: AnyObject {
    func register<T>(type: T.Type, component: Any)
    func resolve<T>() -> T?
}

class DIContainer: DIContainerProtocol {
    private var components: [String: Any] = [:]
    static let shared = DIContainer()
    
    private init() {}
    
    func register<T>(type: T.Type, component: Any) {
        components[String(describing: type)] = component
    }
    
    func resolve<T>() -> T? {
        return components[String(describing: T.self)] as? T
    }
}
