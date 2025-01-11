//
//  NetworkError.swift
//  TVSeries
//
//  Created by Matheus Campos on 07/01/25.
//

/// Custom network errors.
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case notFound
    case serverError
    case networkError(Error)
    case decodingError(Error)
}
