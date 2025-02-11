//
//  GetPokemonsUseCaseTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

@testable import PokemonApp
import XCTest

class GetPokemonsUseCaseTest: XCTestCase {
    private var pokemonRepositoriesStub: PokemonRepositoriesStub!
    private var sut: GetPokemonsUseCase!
   
    
    override func setUpWithError() throws {
        pokemonRepositoriesStub = PokemonRepositoriesStub()
        sut = .init(repository: pokemonRepositoriesStub)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        PokemonRepositoriesStub.error = nil
        PokemonRepositoriesStub.reponseDetail = nil
        PokemonRepositoriesStub.responsePokemons = nil
    }
    
    func testGetPokemonUseCase_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        PokemonRepositoriesStub.responsePokemons = TestDomainConstants.pokemons
        
        //When
        do {
            let response = try await sut.execute(params: .init(offset: 0, limit: 151))
            // Then
            XCTAssertFalse(response.results.isEmpty)
            expectation.fulfill()
        } catch let error {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
    func testGetPokemonUseCase_ResponseError() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        
        PokemonRepositoriesStub.error = NetworkError.emptyJson
        
        //When
        do {
            _ = try await sut.execute(params: .init(offset: 0, limit: 151))
            expectation.fulfill()
        } catch let error {
            // Then
            let jsonEmptyError = NetworkError.emptyJson.localizedDescription
            XCTAssertEqual(error.localizedDescription, jsonEmptyError)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
}
