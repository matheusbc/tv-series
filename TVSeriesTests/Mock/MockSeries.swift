//
//  MockSeries.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
@testable import TVSeries

struct MockSeries {
    static func mockSeriesImage() -> SeriesImage {
        SeriesImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg")
    }

    static func mockSeries() -> Series {
        let name = "Under the Dome"
        let image = mockSeriesImage()
        let genres = [
            "Drama",
            "Science-Fiction",
            "Thriller"
        ]
        let summary = "Under the Dome is the story of a small town that is suddenly..."
        let schedule = Schedule(time: "22:00", days: ["Thursday"])
        return Series(name: name, image: image, genres: genres, summary: summary, schedule: schedule)
    }
}
