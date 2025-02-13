//
//  SearchPokemonViewControllerSpy.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp

final class SearchPokemonViewControllerSpy: BaseViewControllerSpy {
    var showSectionCallBack: (([PokemonObject]) -> Void)?
    var pushToPokemon : ((PokemonObject) -> Void)?
}

extension SearchPokemonViewControllerSpy: SearchPokemonViewType {
    func showSection(_ section: [PokemonObject]){
        showSectionCallBack?(section)
    }
    
    func pushToPokemon(_ pokemon: PokemonObject) {
        pushToPokemon?(pokemon)
    }
}
