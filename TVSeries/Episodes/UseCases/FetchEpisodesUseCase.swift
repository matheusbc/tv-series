//
//  FetchEpisodesUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

/// Use case to fetch the list of Episodes from a TV Series.
final class FetchEpisodesUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}

protocol FetchEpisodesUseCaseProtocol {
    func execute(seriesId: Int) async throws -> [EpisodeDTO]
}

extension FetchEpisodesUseCase: FetchEpisodesUseCaseProtocol {
    func execute(seriesId: Int) async throws -> [EpisodeDTO] {
        try await networkService.request(EpisodesEndpoints.getSeriesEpisodes(id: seriesId))
    }
}
