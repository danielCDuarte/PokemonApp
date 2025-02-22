//
//  DetailPokemonViewControllerTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import XCTest
import SnapshotTesting
@testable import PokemonApp

class DetailPokemonViewControllerTest: XCTestCase {
    private var sut: DetailPokemonViewController!
    private var detailPokemonPresenterSpy: DetailPokemonPresenterSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        detailPokemonPresenterSpy = DetailPokemonPresenterSpy()
        sut = DetailPokemonViewController()
        sut.presenter = detailPokemonPresenterSpy
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        detailPokemonPresenterSpy = nil
        try super.tearDownWithError()
    }
    
    func testInitialEmptyStateDetailPokemon() {
        assertSnapshot(of: sut, as: .image)
    }
    
    func testLayoutWithFullData() {
        // When
        sut.showDetail(TestDomainConstants.detail)
        
        // Then
        assertSnapshot(of: sut, as: .image)
    }
    
    func testLayoutWithNoAbilities() {
        // When
        sut.showDetail(TestDomainConstants.detail)
        
        // Then
        assertSnapshot(of: sut, as: .image)
    }
    
    func testLayoutWithNoStats() {
        // When
        sut.showDetail(TestDomainConstants.detail)
        
        // Then
        assertSnapshot(of: sut, as: .image)
    }
    
    func testScrolledContent() {
        // Given
        sut.showDetail(TestDomainConstants.detail)
        // When
        sut.view.frame = CGRect(x: 0, y: 0, width: 375, height: 400)
        // Then
        assertSnapshot(of: sut, as: .image)
    }
    
}
