//
//  DetailPokemonPresenter.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class DetailPokemonPresenter: BasePresenter {
    
    private var pokemonDetails: DetailObject?
    
    struct InputDependencies {
        let pokemon: PokemonObject
        let getDetailUseCase: AnyUseCase< Int, DetailObject>
    }
    
    private let dependencies: InputDependencies
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    private var ownView: DetailPokemonViewType! {
        return view as? DetailPokemonViewType
    }
    
    override func viewDidLoad() {
        getDetail(dependencies.pokemon.id)
    }
    
    private func getDetail(_ id: Int) {
        ownView.showLoadingIndicator()
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let pokemonDetails = try await dependencies.getDetailUseCase.execute(params: id)
                await MainActor.run {
                    self.bindDetailPokemon(pokemonDetails)
                }
            } catch let error {
                await MainActor.run {
                    self.ownView.hideLoadingIndicator()
                    self.handleException(error: error)
                }
            }
        }
    }
    
    private func bindDetailPokemon(_ pokemonData: DetailObject) {
        ownView.hideLoadingIndicator()
        pokemonDetails = pokemonData
        if let validatePokemonDetails = pokemonDetails {
            ownView.showDetail(validatePokemonDetails)
        }
    }
}

extension DetailPokemonPresenter: DetailPokemonPresenterType {}
