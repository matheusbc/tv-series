//
//  MockNetworkService.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//
import Foundation
@testable import TVSeries

class MockNetworkService: NetworkServiceProtocol {
    var requestResponse: Result<Any, Error>?

    func request<T>(_ endpoint: EndpointProtocol) async throws -> T where T: Decodable {
        guard let response = requestResponse else {
            throw NetworkError.invalidResponse
        }

        switch response {
        case .success(let value):
            guard let result = value as? T else {
                throw NetworkError.decodingError(NSError(domain: "", code: -1))
            }
            return result
        case .failure(let error):
            throw error
        }
    }
}

extension NetworkError: @retroactive Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
