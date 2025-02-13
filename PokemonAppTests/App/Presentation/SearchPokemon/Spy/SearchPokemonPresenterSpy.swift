//
//  SearchPokemonPresenterSpy.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import Foundation
@testable import PokemonApp

final class SearchPokemonPresenterSpy: BasePresenterSpy {
    var didSelectPokemonAtCallBack : ((IndexPath) -> Void)?
    var didSearchPokemonCallBack : ((String) -> Void)?
    var didsearchBarCancelButtonCallBack: (() -> Void)?
}

extension SearchPokemonPresenterSpy: SearchPokemonPresenterType {
    func didSelectPokemonAt(indexPath: IndexPath) {
        didSelectPokemonAtCallBack?(indexPath)
    }
    
    func didSearchPokemon(_ text: String) {
        didSearchPokemonCallBack?(text)
    }
    
    func didsearchBarCancelButton() {
        didsearchBarCancelButtonCallBack?()
    }
}
