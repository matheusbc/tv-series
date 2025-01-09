//
//  MockEpisode.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
@testable import TVSeries

struct MockEpisode {
    static func mockEpisodeImage() -> SeriesImage {
        SeriesImage(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg")
    }

    static func mockEpisode() -> Episode {
        let name = "Pilot"
        let season = 1
        let number = 1
        let image = mockEpisodeImage()
        let summary = "When the residents of Chester's Mill find themselves trapped under a massive transparent dome..."
        return Episode(name: name, season: season, number: number, summary: summary, image: image)
    }
}
