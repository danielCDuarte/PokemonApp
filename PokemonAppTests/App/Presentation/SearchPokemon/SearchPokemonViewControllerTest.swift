//
//  SearchPokemonViewControllerTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import XCTest
import SnapshotTesting
@testable import PokemonApp

class SearchPokemonViewControllerUITests: XCTestCase {
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
    
    func testLayoutInDifferentDeviceSizes() {
        // iPhone SE
        sut.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        assertSnapshot(of: sut, as: .image(on: .iPhoneSe))
        
        // iPhone 13
        sut.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        assertSnapshot(of: sut, as: .image(on: .iPhone13))
        
        // iPhone 13 Pro Max
        sut.view.frame = CGRect(x: 0, y: 0, width: 428, height: 926)
        assertSnapshot(of: sut, as: .image(on: .iPhone13ProMax))
    }
    
}
