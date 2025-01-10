//
//  SeriesCardView.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import SwiftUI
import Kingfisher

struct SeriesCardView: View {
    var series: Series?

    var body: some View {
        HStack(alignment: .center) {
            KFImage(URL(string: series?.image?.medium ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
            VStack(alignment: .leading) {
                Text(series?.name ?? "")
                    .font(.headline)
                    .lineLimit(1)
                Text(series?.genres.joined(separator: ", ") ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
                Text(series?.summary ?? "")
                    .font(.footnote)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    let series = [
        Series(id: 1,
               name: "Serie 1",
               image: SeriesImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                                  original: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg"),
               genres: ["Commedy"],
               summary: "A really funny series.",
               schedule: Schedule(time: "10:00", days: ["Monday", "Wednesday"])),
        Series(id: 2,
               name: "Serie 2",
               image: SeriesImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                                  original: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg"),
               genres: ["Commedy", "Drama"],
               summary: "A really funny series.",
               schedule: Schedule(time: "10:00", days: ["Monday", "Wednesday"])),
        Series(id: 3,
               name: "Serie 3 with a very large title that will not fit in the screen",
               image: SeriesImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                                  original: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg"),
               genres: ["Commedy", "Drama", "Science-Fiction", "Thriller", "Action"],
               summary: "A really funny series. A really funny series. A really funny series. A really funny series.",
               schedule: Schedule(time: "10:00", days: ["Monday", "Wednesday"]))
    ]
    List(series) { series in
        SeriesCardView(series: series)
    }
    .listStyle(.plain)
}
