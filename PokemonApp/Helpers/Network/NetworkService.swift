//
//  NetworkService.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 10/02/25.
//

import Foundation

class NetworkService {
    var baseURL: URL?
    var urlSession: URLSession
    var decoder: JSONDecoder
    
    init(url: String,
         urlSession: URLSession,
         decoder: JSONDecoder) {
        self.baseURL = URL(string: url)
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    private func getRequestHeaders<Response>(_ request: NetworkRequest<Response>) -> [String: String] {
        var headers: [String: String] = [:]
        headers[DataConstants.APIClient.contentType] = DataConstants.InnerConstants.applicationJson
        return headers
    }
    
    private func getBaseUrl(path: String, parameters: [String: Any] = [:]) -> URL? {
        guard let baseUrl = baseURL?.appendingPathComponent(path) else { return nil }
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        
        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }
        return urlComponents.url
    }
    
    private func getUrlRequest<Response>(_ endPoint: NetworkRequest<Response>) -> URLRequest? {
        var url: URL?
        var httpBody: Data?
        if let parameters = endPoint.parameters {
            if endPoint.method != .GET {
                let body = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                httpBody = body
                url = getBaseUrl(path: endPoint.relativePath)
            } else {
                url = getBaseUrl(path: endPoint.relativePath, parameters: parameters)
            }
        } else {
            url = getBaseUrl(path: endPoint.relativePath)
        }
        guard let requestUrl: URL = url else { return nil }
        let headers = getRequestHeaders(endPoint)
        var request = URLRequest(url: requestUrl)
        request.httpBody = httpBody
        request.allHTTPHeaderFields = headers
        request.httpMethod = endPoint.method.rawValue
        return request
    }
}

extension NetworkService: NetworkServiceType {
    
    
    func setBaseUrl(_ baseUrl: String) {
        baseURL = URL(string: baseUrl)
    }
    
    func request<Response>(
        _ endpoint: NetworkRequest<Response>,
        queue: DispatchQueue = .main) async throws -> Response where Response : Decodable {
        guard let request = getUrlRequest(endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200 ..< 300 ~= httpResponse.statusCode) {
            throw NetworkError.apiError(
                code: httpResponse.statusCode,
                error: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            )
        }

        do {
            let decodedResponse = try decoder.decode(Response.self, from: data)
            return try await withCheckedThrowingContinuation { continuation in
                queue.async {
                    continuation.resume(returning: decodedResponse)
                }
            }
        } catch {
            throw error
        }
        
    }
}
