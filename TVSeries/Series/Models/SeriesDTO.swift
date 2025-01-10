//
//  SeriesDTO.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//

struct SeriesDTO: Decodable, Identifiable {
    let id: Int
    let name: String
    let image: ImageDTO?
    let genres: [String]
    let summary: String?
    let schedule: ScheduleDTO
    let rating: RatingDTO?
    let premiered: String?
    let ended: String?
}

extension SeriesDTO: Parsable {
    typealias ParsedType = Series

    func parse() -> ParsedType {
        Series(id: self.id,
               name: self.name,
               image: self.image?.medium ?? "",
               genres: self.genres,
               summary: self.summary ?? "",
               schedule: self.schedule.parse())
    }
}
