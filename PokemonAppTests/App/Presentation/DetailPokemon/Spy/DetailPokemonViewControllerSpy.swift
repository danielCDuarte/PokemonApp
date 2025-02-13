//
//  DetailPokemonViewControllerSpy.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp

final class DetailPokemonViewControllerSpy: BaseViewControllerSpy {
    var showDetailCallBack: ((DetailObject) -> Void)?
}

extension DetailPokemonViewControllerSpy: DetailPokemonViewType {
    func showDetail(_ detail: DetailObject) {
        showDetailCallBack?(detail)
    }
}
