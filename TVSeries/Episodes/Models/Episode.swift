//
//  Episode.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//

struct Episode: Decodable {
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: SeriesImage
}
