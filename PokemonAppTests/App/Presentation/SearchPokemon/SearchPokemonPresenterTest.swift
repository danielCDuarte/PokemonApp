//
//  SearchPokemonPresenterTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp
import XCTest

final class SearchPokemonPresenterTest: XCTestCase {
    private var sut: SearchPokemonPresenter!
    private var searchPokemonViewControllerSpy: SearchPokemonViewControllerSpy!
    private var getPokemonsUseCaseStub: GetPokemonsUseCaseStub!
    
    override func setUp() {
        super.setUp()
        
        searchPokemonViewControllerSpy = SearchPokemonViewControllerSpy()
        
        getPokemonsUseCaseStub = GetPokemonsUseCaseStub()
        let dependencies = SearchPokemonPresenter.InputDependencies(
            getPokemonsUseCase: getPokemonsUseCaseStub
        )
        sut = SearchPokemonPresenter(dependencies: dependencies)
    }
    
    override func tearDown() {
        searchPokemonViewControllerSpy = nil
        GetPokemonsUseCaseStub.error = nil
        GetPokemonsUseCaseStub.response = nil
        getPokemonsUseCaseStub = nil
        sut = nil
        super.tearDown()
    }
    
    func testPokemons_WhenThereisSuccess_ThenCallShowSections() {
        // Given
        let expectation = XCTestExpectation(description: "Get Pokemons")
        var isCallShowSections = false
        
        // When
        GetPokemonsUseCaseStub.response =  TestDomainConstants.pokemons
        
        searchPokemonViewControllerSpy.showSectionCallBack = { _ in
            isCallShowSections = true
            expectation.fulfill()
        }
        
        // Then
        sut.bind(withView: searchPokemonViewControllerSpy)
        sut.viewDidLoad()
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallShowSections)
    }
    
    func testGetPokemons_WhenThereisError_ThenCallHideLoadingIndicator() {
        // Given
        let expectation = XCTestExpectation(description: "Get Pokemons")
        var isCallHideLoadingIndicator = false
        
        // When
        GetPokemonsUseCaseStub.error = NetworkError.emptyJson

        searchPokemonViewControllerSpy.hideLoadingIndicatorCallBack = {
            isCallHideLoadingIndicator = true
            expectation.fulfill()
        }
        
        // Then
        sut.bind(withView: searchPokemonViewControllerSpy)
        sut.viewDidLoad()
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallHideLoadingIndicator)
    }
    
    func testDidSelectPokemonAt_WhenTapOnSelectedPokemon_ThenCallPushToPokemon() {
        // Given
        let expectation = XCTestExpectation(description: "Get Pokemons")
        var isCallPushToPokemon = false
        
        // When
        GetPokemonsUseCaseStub.response =  TestDomainConstants.pokemons
        
        searchPokemonViewControllerSpy.showSectionCallBack = { _ in
            self.sut.didSelectPokemonAt(indexPath: IndexPath(row: 0, section: 1))
        }
        
        searchPokemonViewControllerSpy.pushToPokemon = { _ in
            isCallPushToPokemon = true
            expectation.fulfill()
        }
        
        // Then
        sut.bind(withView: searchPokemonViewControllerSpy)
        sut.viewDidLoad()
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallPushToPokemon)
    }
    
    
    func testDidSearchPokemon_WhenTextIsEmpty_ThenCallShowSection(){
        // Given
        let expectation = XCTestExpectation(description: "Get Pokemons")
        var count = 0
        var isCallShowSections = false
        
        // When
        GetPokemonsUseCaseStub.response =  TestDomainConstants.pokemons
        
        searchPokemonViewControllerSpy.showSectionCallBack = { _ in
            count += 1
            if count >= 2 {
                isCallShowSections = true
                expectation.fulfill()
            }
        }
        
        // Then
        sut.bind(withView: searchPokemonViewControllerSpy)
        sut.viewDidLoad()
        sut.didSearchPokemon("")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallShowSections)
    }
    
    func testDidSearchPokemon_WhenTextIsNotEmpty_ThenCallShowSection(){
        // Given
        let expectation = XCTestExpectation(description: "Get Pokemons")
        var count = 0
        var isCallShowSections = false
        
        // When
        GetPokemonsUseCaseStub.response =  TestDomainConstants.pokemons
        
        searchPokemonViewControllerSpy.showSectionCallBack = { _ in
            count += 1
            if count >= 2 {
                isCallShowSections = true
                expectation.fulfill()
            }
        }
        
        // Then
        sut.bind(withView: searchPokemonViewControllerSpy)
        sut.viewDidLoad()
        sut.didSearchPokemon("bulbasaur")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallShowSections)
    }
    
    func testDidsearchBarCancelButton_WhenTabInCancelButton_ThenCallShowSection(){
        // Given
        let expectation = XCTestExpectation(description: "Get Pokemons")
        var count = 0
        var isCallShowSections = false
        
        // When
        GetPokemonsUseCaseStub.response =  TestDomainConstants.pokemons
        
        searchPokemonViewControllerSpy.showSectionCallBack = { _ in
            count += 1
            if count >= 2 {
                isCallShowSections = true
                expectation.fulfill()
            }
        }
        
        // Then
        sut.bind(withView: searchPokemonViewControllerSpy)
        sut.viewDidLoad()
        sut.didsearchBarCancelButton()
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallShowSections)
    }
}
