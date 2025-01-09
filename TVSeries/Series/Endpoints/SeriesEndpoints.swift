//
//  SeriesEndpoints.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//
import Foundation

/// Endpoints related to TV Series.
enum SeriesEndpoints {
    case getSeriesList(page: Int)
    case searchSeries(query: String)
    case getSeries(id: Int)
}

extension SeriesEndpoints: EndpointProtocol {
    var path: String {
        switch self {
        case .getSeriesList(let page):
            return "/shows?page=\(page)"
        case .searchSeries(let query):
            return "/search/shows?q=\(query)"
        case .getSeries(let id):
            return "/shows/\(id)"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getSeriesList, .searchSeries, .getSeries:
            return .get
        }
    }
    var body: Data? {
        switch self {
        case .getSeriesList, .searchSeries, .getSeries:
            return nil
        }
    }
    var headers: [String: String]? {
        ["Content-Type": "application/json",
         "Accept": "application/json" ]
    }
}
