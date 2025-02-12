//
//  SearchPokemonPresenter.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

class SearchPokemonPresenter: BasePresenter {
    
    private var pokemons: [PokemonObject] = []
    private var filteredPokemons: [PokemonObject] = []
    private var isSearching: Bool = false
    
    private struct Constants {
        static let offset: Int = 0
        static let limit: Int = 151
    }
    
    struct InputDependencies {
        let getPokemonsUseCase: AnyUseCase< PokemonsParamsObject, PokemonsObject>
    }
    
    private let dependencies: InputDependencies
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    private var ownView: SearchPokemonViewType! {
        return view as? SearchPokemonViewType
    }
    
    override func viewDidLoad() {
        getPokemons()
    }
    
    private func getPokemons() {
        ownView.showLoadingIndicator()
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let pokemonsResult = try await dependencies.getPokemonsUseCase.execute(
                    params: .init(
                        offset: Constants.offset,
                        limit: Constants.limit)
                )
                await MainActor.run {
                    self.bindPokemons(pokemonsResult.results)
                }
            } catch let error {
                await MainActor.run {
                    self.ownView.hideLoadingIndicator()
                    self.handleException(error: error)
                }
            }
        }
    }
    
    private func bindPokemons(_ pokemonList: [PokemonObject]) {
        ownView.hideLoadingIndicator()
        pokemons = pokemonList.sorted { $0.name < $1.name }
        ownView.showSection(pokemons)
    }
}

extension SearchPokemonPresenter: SearchPokemonPresenterType {
    func didSelectPokemonAt(indexPath: IndexPath) {
        var pokemonSelected: PokemonObject?
        if isSearching {
            if filteredPokemons.indices.contains(indexPath.row) {
                pokemonSelected = filteredPokemons[indexPath.row]
            }
        } else {
            if pokemons.indices.contains(indexPath.row) {
                pokemonSelected = pokemons[indexPath.row]
            }
        }
        guard let validatePokemonSelected = pokemonSelected else { return }
        ownView.pushToPokemon(validatePokemonSelected)
        
    }
    
    func didSearchPokemon(_ text: String) {
        if text.isEmpty {
            isSearching = false
            filteredPokemons.removeAll()
        } else {
            isSearching = true
            filteredPokemons = pokemons.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
        ownView.showSection(filteredPokemons.isEmpty ? pokemons : filteredPokemons)
    }
    
    func didsearchBarCancelButton() {
        isSearching = false
        filteredPokemons.removeAll()
        ownView.hideLoadingIndicator()
        ownView.showSection(pokemons)
    }
}
