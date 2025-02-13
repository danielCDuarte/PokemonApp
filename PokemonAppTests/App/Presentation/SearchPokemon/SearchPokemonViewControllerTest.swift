//
//  SearchPokemonViewControllerTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import XCTest
import SnapshotTesting
@testable import PokemonApp

class SearchPokemonViewControllerTest: XCTestCase {
    private var sut: SearchPokemonViewController!
    private var searchPokemonCoordinatorSpy: SearchPokemonCoordinatorSpy!
    private var searchPokemonPresenterSpy: SearchPokemonPresenterSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let container = DIContainer.shared
        
        searchPokemonCoordinatorSpy = SearchPokemonCoordinatorSpy(
            navigationController: UINavigationController(),
            container: container
        )
        searchPokemonPresenterSpy = SearchPokemonPresenterSpy()
        sut = SearchPokemonViewController()
        sut.coordinator = searchPokemonCoordinatorSpy
        sut.presenter = searchPokemonPresenterSpy
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        searchPokemonCoordinatorSpy = nil
        searchPokemonPresenterSpy = nil
        try super.tearDownWithError()
    }
    
    func testEmptyStateInitialLayout() {
        assertSnapshot(of: sut, as: .image)
    }
    
    func testLayoutWithPokemons() {
        // When
        sut.showSection(TestDomainConstants.pokemons.results)
        
        // Then
        assertSnapshot(of: sut, as: .image)
    }
    
    func testLayoutWithSearchBarActive() {
        // Given
        let searchBar = sut.navigationItem.titleView as? UISearchBar
        
        // When
        searchBar?.becomeFirstResponder()
        searchBar?.text = "bulbasaur"
        
        // Then
        assertSnapshot(of: sut, as: .image)
    }
}
