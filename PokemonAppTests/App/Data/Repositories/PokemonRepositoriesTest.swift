//
//  PokemonRepositoriesTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation
import XCTest

@testable import PokemonApp

final class PokemonRepositoriesTest: XCTestCase {
    private var networkService: NetworkServiceType!
    private var sut: PokemonRepositoriesType!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        sut = PokemonRepositories(networkService: networkService)
    }
    
    override func tearDown() {
        NetworkServiceMock.response = nil
        NetworkServiceMock.error = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetPokemonsRepository_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        NetworkServiceMock.response = TestDataConstants.pokemonsResponse as AnyObject
        
        //When
        do {
            // then
            let response = try await sut.getPokemons(with: 0, limit: 151)
            XCTAssertNotNil(response)
            successExpectation.fulfill()
            
        } catch {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, successExpectation], timeout: 1.0)
    }
    
    func testGetPokemonsRepository_ResponseFailure() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        NetworkServiceMock.response = TestDataConstants.pokemonsResponse as AnyObject
        NetworkServiceMock.error = NetworkError.emptyJson
        
        //When
        do {
            _ = try await sut.getPokemons(with: 0, limit: 151)
            expectation.fulfill()
        } catch let error {
            // then
            XCTAssertEqual(error.localizedDescription, NetworkError.emptyJson.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
    func testGetDetailsRepository_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        NetworkServiceMock.response = TestDataConstants.detailResponse as AnyObject
        
        //When
        do {
            // then
            let response = try await sut.getDetails(1)
            XCTAssertNotNil(response)
            successExpectation.fulfill()
            
        } catch {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, successExpectation], timeout: 1.0)
    }
    
    func testGetDetailsRepository_ResponseFailure() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        NetworkServiceMock.response = TestDataConstants.detailResponse as AnyObject
        NetworkServiceMock.error = NetworkError.emptyJson
        
        //When
        do {
            _ = try await sut.getDetails(1)
            expectation.fulfill()
        } catch let error {
            // then
            XCTAssertEqual(error.localizedDescription, NetworkError.emptyJson.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
}
