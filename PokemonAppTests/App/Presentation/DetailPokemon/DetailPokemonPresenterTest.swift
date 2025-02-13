//
//  DetailPokemonPresenterTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp
import XCTest

final class DetailPokemonPresenterTest: XCTestCase {
    private var sut: DetailPokemonPresenter!
    private var detailPokemonViewControllerSpy: DetailPokemonViewControllerSpy!
    private var getDetailUseCaseStub: GetDetailUseCaseStub!
    
    override func setUp() {
        super.setUp()
        
        detailPokemonViewControllerSpy = DetailPokemonViewControllerSpy()
        
        getDetailUseCaseStub = GetDetailUseCaseStub()
        let dependencies = DetailPokemonPresenter.InputDependencies(
            pokemon: TestDomainConstants.pokemon,
            getDetailUseCase: getDetailUseCaseStub
        )
        sut = DetailPokemonPresenter(dependencies: dependencies)
    }
    
    override func tearDown() {
        detailPokemonViewControllerSpy = nil
        GetDetailUseCaseStub.error = nil
        GetDetailUseCaseStub.response = nil
        getDetailUseCaseStub = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetDetailPokemon_WhenThereisSuccess_ThenCallShowDetail() {
        // Given
        let expectation = XCTestExpectation(description: "Get Detail Pokemon")
        var isCallShowDetail = false
        
        // When
        GetDetailUseCaseStub.response =  TestDomainConstants.detail
        
        detailPokemonViewControllerSpy.showDetailCallBack = { _ in
            isCallShowDetail = true
            expectation.fulfill()
        }
        
        // Then
        sut.bind(withView: detailPokemonViewControllerSpy)
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallShowDetail)
    }
    
    func testGetDetailPokemon_WhenThereisError_ThenCallHideLoadingIndicator() {
        // Given
        let expectation = XCTestExpectation(description: "Get Detail Pokemon")
        var isCallHideLoadingIndicator = false
        
        // When
        GetDetailUseCaseStub.error = NetworkError.emptyJson

        detailPokemonViewControllerSpy.hideLoadingIndicatorCallBack = {
            isCallHideLoadingIndicator = true
            expectation.fulfill()
        }
        
        // Then
        sut.bind(withView: detailPokemonViewControllerSpy)
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isCallHideLoadingIndicator)
    }
}

