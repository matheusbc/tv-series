//
//  FetchEpisodesUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

final class FetchEpisodesUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

protocol FetchEpisodesUseCaseProtocol {
    func execute(seriesId: Int) async throws -> [Episode]
}

extension FetchEpisodesUseCase: FetchEpisodesUseCaseProtocol {
    func execute(seriesId: Int) async throws -> [Episode] {
        try await networkService.request(EpisodesEndpoints.getSeriesEpisodes(id: seriesId))
    }
}
