//
//  SearchSeriesUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

/// Use case to search TV series from a query.
final class SearchSeriesUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}

protocol SearchSeriesUseCaseProtocol {
    func execute(query: String) async throws -> [SearchSeriesDTO]
}

extension SearchSeriesUseCase: SearchSeriesUseCaseProtocol {
    func execute(query: String = "") async throws -> [SearchSeriesDTO] {
        try await networkService.request(SeriesEndpoints.searchSeries(query: query))
    }
}
