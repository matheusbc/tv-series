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
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}

protocol FetchSeriesUseCaseProtocol {
    func execute(page: Int) async throws -> [SeriesDTO]
}

extension FetchSeriesUseCase: FetchSeriesUseCaseProtocol {
    func execute(page: Int = 0) async throws -> [SeriesDTO] {
        try await networkService.request(SeriesEndpoints.getSeriesList(page: page))
    }
}
