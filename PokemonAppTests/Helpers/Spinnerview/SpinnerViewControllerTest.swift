//
//  SpinnerViewControllerTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import XCTest
import SnapshotTesting
@testable import PokemonApp

class SpinnerViewControllerTest: XCTestCase {
    private var sut: SpinnerViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SpinnerViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInitialEmptyState() {
        assertSnapshot(of: sut, as: .image)
    }
}
