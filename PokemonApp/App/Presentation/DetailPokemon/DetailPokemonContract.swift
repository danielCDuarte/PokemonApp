//
//  DetailPokemonContract.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

protocol DetailPokemonViewType: BaseView {
    func showCharacter(_ detail: DetailObject)
}

protocol DetailPokemonPresenterType: BasePresenterProtocol {
}

