//
//  PokemonsMapperTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

@testable import PokemonApp
import XCTest

class PokemonsMapperTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testCitiesMapper_WhenInputIsFilled_ThenReturnObjectFilled() throws {
        // Given
        let input = TestDataConstants.pokemonsResponse
        // when
        let result = PokemonsMapper.map(input: input)
        // then
        XCTAssertEqual(result.results.count, input.results.count)
    }
}
