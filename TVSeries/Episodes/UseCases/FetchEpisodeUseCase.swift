//
//  FetchEpisodeUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

/// Use case to fetch an Episode from a TV Series.
final class FetchEpisodeUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}

protocol FetchEpisodeUseCaseProtocol {
    func execute(seriesId: Int, season: Int, episode: Int) async throws -> EpisodeDTO
}

extension FetchEpisodeUseCase: FetchEpisodeUseCaseProtocol {
    func execute(seriesId: Int, season: Int, episode: Int) async throws -> EpisodeDTO {
        try await networkService.request(EpisodesEndpoints.getEpisode(seriesId: seriesId,
                                                                      season: season,
                                                                      episode: episode))
    }
}
