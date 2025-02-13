//
//  SearchPokemonCoordinatorSpy.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import Foundation
@testable import PokemonApp

final class SearchPokemonCoordinatorSpy: SearchPokemonCoordinator {
    var pushDetailCallBack: ((PokemonObject) -> Void)?
    
    override func pushDetail(_ pokemon: PokemonObject) {
        pushDetailCallBack?(pokemon)
    }
}
