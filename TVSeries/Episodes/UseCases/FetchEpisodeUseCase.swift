//
//  FetchEpisodeUseCase.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

final class FetchEpisodeUseCase {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

protocol FetchEpisodeUseCaseProtocol {
    func execute(seriesId: Int, season: Int, episode: Int) async throws -> Episode
}

extension FetchEpisodeUseCase: FetchEpisodeUseCaseProtocol {
    func execute(seriesId: Int, season: Int, episode: Int) async throws -> Episode {
        try await networkService.request(EpisodesEndpoints.getEpisode(seriesId: seriesId,
                                                                      season: season,
                                                                      episode: episode))
    }
}
