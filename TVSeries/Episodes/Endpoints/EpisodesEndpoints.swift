//
//  EpisodesEndpoints.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//
import Foundation

/// Endpoints related to Episodes.
enum EpisodesEndpoints {
    case getSeriesEpisodes(id: Int)
    case getEpisode(seriesId: Int, season: Int, episode: Int)
}

extension EpisodesEndpoints: EndpointProtocol {
    var path: String {
        switch self {
        case .getSeriesEpisodes(let id):
            return "/shows/\(id)/episodes"
        case .getEpisode(let seriesId, let season, let episode):
            return "/shows/\(seriesId)/episodebynumber?season=\(season)&number=\(episode)"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getSeriesEpisodes, .getEpisode:
            return .get
        }
    }
    var body: Data? {
        switch self {
        case .getSeriesEpisodes, .getEpisode:
            return nil
        }
    }
    var headers: [String: String]? {
        ["Content-Type": "application/json",
         "Accept": "application/json" ]
    }
}
