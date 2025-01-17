//
//  SeriesDetailsView.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI
import Kingfisher

struct SeriesDetailsView: View {
    @State var series: Series
    @Binding var title: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(series.name)
                    .font(.largeTitle.bold())
                    .onScrollVisibilityChange { isVisible in
                        title = isVisible ? "" : series.name
                    }
                HStack(alignment: .top) {
                    KFImage(URL(string: series.image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                    VStack(alignment: .leading) {
                        Text("Schedule")
                            .font(.headline)
                        Text(series.schedule.days.joined(separator: ", "))
                            .font(.subheadline)
                        Text(series.schedule.time)
                            .font(.subheadline)
                        Text("Genres")
                            .font(.headline)
                            .padding(.top, 10)
                        Text(series.genres.joined(separator: ", "))
                            .font(.subheadline)
                    }
                }
                Text("Summary")
                    .font(.title2.bold())
                HTMLText(htmlString: series.summary, font: .callout)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .onAppear {
            title = ""
        }
        .onDisappear {
            title = series.name
        }
    }
}

#Preview {
    let series = Series(id: 1,
                        name: "Serie 1",
                        image: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                        genres: ["Commedy", "Drama", "Thriller", "Science-Fiction"],
                        summary: "A really funny series.",
                        schedule: Schedule(time: "10:00", days: ["Monday", "Wednesday"]))
    NavigationView {
        SeriesDetailsView(series: series, title: .constant(""))
    }
}
