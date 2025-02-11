//
//  GetDetailUseCaseTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

@testable import PokemonApp
import XCTest

class GetDetailUseCaseTest: XCTestCase {
    private var pokemonRepositoriesStub: PokemonRepositoriesStub!
    private var sut: GetDetailUseCase!
   
    
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
    
    func testGetDetailUseCase_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        PokemonRepositoriesStub.reponseDetail = TestDomainConstants.detail
        
        //When
        do {
            let response = try await sut.execute(params: "1")
            // Then
            XCTAssertFalse(response.abilities.isEmpty)
            expectation.fulfill()
        } catch let error {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
    func testGetDetailUseCase_ResponseError() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        
        PokemonRepositoriesStub.error = NetworkError.emptyJson
        
        //When
        do {
            _ = try await sut.execute(params: "1")
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
