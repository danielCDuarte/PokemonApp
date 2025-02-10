//
//  NetworkServiceTest.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

@testable import PokemonApp
import XCTest

class NetworkServiceTest: XCTestCase {
    private var sut: NetworkServiceType!
    private var session: URLSession!
    private var decoder: JSONDecoder!
    static let baseUrl = DataConstants.baseUrl
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        session = URLSession(configuration: config)
        decoder = JSONDecoder()
        sut = NetworkService(url: DataConstants.baseUrl, urlSession: session, decoder: decoder)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        URLProtocolMock.testURLs = [:]
        URLProtocolMock.error = nil
        URLProtocolMock.response = nil
    }
    
    func testNetworkService_WhenMakeARequestSuccessful_ThenTheResponseShouldBeSuccess() async throws {
        //Given
        let expectationReceive = expectation(description: "receiveValue")
        let expectationFailure = expectation(description: "failure")
        expectationFailure.isInverted = true
        let endPoint = NetworkRequest<APIPokemonsResponse>(
            method: .GET,
            relativePath:"",
            parameters: [
                "offset": 0,
                "limit": 151
            ]
        )
        let decoder = JSONEncoder()
        let usersURL = URL.getUrl(from: DataConstants.baseUrl)
        let encodedData = try decoder.encode(TestDataConstants.pokemonsResponse)
        let jsonString = String(data: encodedData, encoding: .utf8)
        let jsonData = jsonString!.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [usersURL: jsonData]
        URLProtocolMock.response = HTTPURLResponse(
            url: URL(string: "http://localhost:5000")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        //When
        do {
            let response = try await sut.request(endPoint, queue: .main)
            XCTAssertNotNil(response)
            print(response)
            expectationReceive.fulfill()
        }
        catch {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationReceive, expectationFailure], timeout: 1.0)
    }
    
    func testNetworkService_WhenMakeARequestSuccessfulButRequestFail_ThenCatchAError() async throws {
        //Given
        let expectationReceive = expectation(description: "Invalid.receiveValue")
        let expectationFailure = expectation(description: "Invalid.failure")
        expectationFailure.isInverted = true
        
        let endPoint = NetworkRequest<APIPokemonsResponse>(
            method: .GET,
            relativePath:"",
            parameters: [
                "offset": 0,
                "limit": 151
            ]
        )
        
        URLProtocolMock.response = HTTPURLResponse(
            url: URL(string: "http://localhost:5000/")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        //When
        do {
            let response = try await sut.request(endPoint, queue: .main)
            XCTAssertNotNil(response)
            print(response)
            expectationReceive.fulfill()
        }
        catch {
            print(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationReceive, expectationFailure], timeout: 1.0)
    }
    
    func testNetworkService_WhenInvalidURL_ThenCatchAError() async throws {
        //Given
        let expectationReceive = expectation(description: "Invalid.receiveValue")
        expectationReceive.isInverted = true
        let expectationFailure = expectation(description: "Invalid.failure")
        
        sut = NetworkService(url: "", urlSession: session, decoder: decoder)
        
        let endPoint = NetworkRequest<APIPokemonsResponse>(
            method: .GET,
            relativePath:"",
            parameters: [
                "offset": 0,
                "limit": 151
            ]
        )
        
        URLProtocolMock.response = HTTPURLResponse(
            url: URL(string: "http://localhost:5000/")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        //When
        do {
            let response = try await sut.request(endPoint, queue: .main)
            XCTAssertNotNil(response)
            print(response)
            expectationReceive.fulfill()
        }
        catch {
            print(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        
        //Then
        await fulfillment(of: [expectationReceive, expectationFailure], timeout: 1.0)
    }
}
