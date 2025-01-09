//
//  MockEndpoints.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//
import Foundation
@testable import TVSeries

enum TestEndpoints {
    case invalidURL
}

extension TestEndpoints: EndpointProtocol {
    var path: String {
        switch self {
        case .invalidURL:
            return "\\shows?page=#"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .invalidURL:
            return .get
        }
    }
    var body: Data? {
        switch self {
        case .invalidURL:
            return nil
        }
    }
    var headers: [String: String]? {
        ["Content-Type": "application/json",
         "Accept": "application/json" ]
    }
}
