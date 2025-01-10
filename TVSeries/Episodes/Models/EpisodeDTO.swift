//
//  EpisodeDTO.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//

struct EpisodeDTO: Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: ImageDTO?
}

extension EpisodeDTO: Parsable {
    typealias ParsedType = Episode

    func parse() -> Episode {
        Episode(id: self.id,
                name: self.name,
                season: self.season,
                number: self.number,
                summary: self.summary ?? "",
                image: image?.medium ?? "")
    }
}
