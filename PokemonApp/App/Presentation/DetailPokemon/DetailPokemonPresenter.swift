//
//  DetailPokemonPresenter.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class DetailPokemonPresenter: BasePresenter {
    struct InputDependencies {
        let pokemon: PokemonObject
    }
    
    private let dependencies: InputDependencies
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    private var ownView: DetailPokemonViewType! {
        return view as? DetailPokemonViewType
    }
    
    override func viewDidLoad() {
    }
}

extension DetailPokemonPresenter: DetailPokemonPresenterType {}
