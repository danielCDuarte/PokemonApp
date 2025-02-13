//
//  ErrorViewControllerTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

import XCTest
import SnapshotTesting
@testable import PokemonApp

class ErrorViewControllerTest: XCTestCase {
    private var sut: ErrorViewController!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func setupViewController(with error: NetworkError) {
        sut = ErrorViewController(error: error) {}
        sut.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
    }
    
    func testBadURLError() {
        setupViewController(with: .badURL(""))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testAPIError() {
        setupViewController(with: .apiError(code: 500, error: "Internal Server Error"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testInvalidJSONError() {
        setupViewController(with: .invalidJSON("Invalid JSON format"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testUnauthorizedError() {
        setupViewController(with: .unauthorized(code: 401, error: "Please login to continue"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testBadRequestError() {
        setupViewController(with: .badRequest(code: 400, error: "Invalid parameters"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testNoResponseError() {
        setupViewController(with: .noResponse("No response from server"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testUnableToParseDataError() {
        setupViewController(with: .unableToParseData("Unable to parse response"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testUnknownError() {
        setupViewController(with: .unknown(code: 0, error: "An unknown error occurred"))
        assertSnapshot(of: sut, as: .image)
    }
    
    func testInvalidUrlError() {
        setupViewController(with: .invalidUrl)
        assertSnapshot(of: sut, as: .image)
    }
    
    func testServerError() {
        setupViewController(with: .serverError)
        assertSnapshot(of: sut, as: .image)
    }
    
    func testEmptyJsonError() {
        setupViewController(with: .emptyJson)
        assertSnapshot(of: sut, as: .image)
    }
}
