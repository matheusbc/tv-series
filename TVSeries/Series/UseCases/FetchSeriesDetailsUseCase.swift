//
//  FetchSeriesDetailsUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

/// Use case to fetch a TV Series.
final class FetchSeriesDetailsUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

protocol FetchSeriesDetailsUseCaseProtocol {
    func execute(seriesId: Int) async throws -> Series
}

extension FetchSeriesDetailsUseCase: FetchSeriesDetailsUseCaseProtocol {
    func execute(seriesId: Int) async throws -> Series {
        try await networkService.request(SeriesEndpoints.getSeries(id: seriesId))
    }
}
