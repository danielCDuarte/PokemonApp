//
//  PokemonDetailMapperTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

@testable import PokemonApp
import XCTest

class PokemonDetailMapperTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testCitiesMapper_WhenInputIsFilled_ThenReturnObjectFilled() throws {
        // Given
        let input = TestDataConstants.detailResponse
        // when
        let result = PokemonDetailMapper.map(input: input)
        // then
        XCTAssertEqual(result.abilities.count, input.abilities.count)
    }
}
