//
//  FetchSeriesUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

/// Use case to fetch a list of TV Series paginated.
final class FetchSeriesUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

protocol FetchSeriesUseCaseProtocol {
    func execute(page: Int) async throws -> [Series]
}

extension FetchSeriesUseCase: FetchSeriesUseCaseProtocol {
    func execute(page: Int = 0) async throws -> [Series] {
        try await networkService.request(SeriesEndpoints.getSeriesList(page: page))
    }
}
