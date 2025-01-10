//
//  Series.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

struct Series: Decodable, Identifiable {
    let id: Int
    let name: String
    let image: SeriesImage?
    let genres: [String]
    let summary: String
    let schedule: Schedule
}
