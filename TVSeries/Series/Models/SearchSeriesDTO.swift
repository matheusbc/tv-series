//
//  SearchSeriesDTO.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//

struct SearchSeriesDTO: Decodable {
    let score: Double
    let show: SeriesDTO
}

extension SearchSeriesDTO: Parsable {
    typealias ParsedType = Series

    func parse() -> ParsedType {
        Series(id: self.show.id,
               name: self.show.name,
               image: self.show.image?.medium ?? "",
               genres: self.show.genres,
               summary: self.show.summary ?? "",
               schedule: self.show.schedule.parse())
    }
}
