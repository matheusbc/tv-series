//
//  Endpoint.swift
//  TVSeries
//
//  Created by Matheus Campos on 07/01/25.
//
import Foundation

/// Endpoints protocol. Used to create all the endpoints used on the app.
protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

/// Endpoints enumeration containing all the API's URLs.
enum Endpoints {
    static var baseURL: String {
        return tvMazeAPI
    }
    static let tvMazeAPI: String = "https://api.tvmaze.com"
}
