//
//  NetworkService.swift
//  TVSeries
//
//  Created by Matheus Campos on 07/01/25.
//
import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let successCodes = 200...299
    private let session: URLSession
    private let decoder: JSONDecoder

    /// NetworkService initializer.
    /// - Parameters:
    ///   - session: URLSession to be used on network requests. Default is URLSession.shared.
    ///   - decoder: Decoder used to decode request response data. Default is JSONDecoder.
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    /// Send request to the given endpoint. This function works asynchronously.
    /// - Parameter endpoint: Endpoint to be requested that conforms to EndpointProtocol.
    /// - Returns: Returns data that conforms to Decodable.
    func request<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T {
        guard let url = URL(string: Endpoints.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            // Handling only 404 that will be used on this app version.
            guard successCodes.contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 404 {
                    throw NetworkError.notFound
                }
                throw NetworkError.serverError
            }

            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error)
        } catch {
            throw NetworkError.networkError(error)
        }
    }
}
