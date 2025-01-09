//
//  SearchSeriesUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

final class SearchSeriesUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

protocol SearchSeriesUseCaseProtocol {
    func execute(query: String) async throws -> [Series]
}

extension SearchSeriesUseCase: SearchSeriesUseCaseProtocol {
    func execute(query: String = "") async throws -> [Series] {
        try await networkService.request(SeriesEndpoints.searchSeries(query: query))
    }
}
