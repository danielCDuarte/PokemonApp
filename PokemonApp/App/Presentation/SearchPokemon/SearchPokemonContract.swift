//
//  SearchPokemonContract.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

protocol SearchPokemonViewType: BaseView {
    func showSection(_ section: [PokemonObject])
    func pushToPokemon(_ pokemon: PokemonObject)
}

protocol SearchPokemonPresenterType: BasePresenterProtocol {
    func didSelectPokemonAt(indexPath: IndexPath)
    func didSearchPokemon(_ text: String)
    func didsearchBarCancelButton()
}
