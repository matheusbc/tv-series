//
//  EpisodeCardView.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI
import Kingfisher

struct EpisodeCardView: View {
    var episode: Episode?

    var body: some View {
        HStack(alignment: .center) {
            KFImage(URL(string: episode?.image ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack(alignment: .leading) {
                Text(episode?.name ?? "")
                    .font(.headline)
                    .lineLimit(1)
                HStack {
                    if let episode {
                        Text("Season \(episode.season)")
                            .font(.subheadline)
                        Text("-")
                            .font(.subheadline)
                        Text("Episode \(episode.number)")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

#Preview {
    let episodes = [
        Episode(id: 1,
                name: "Pilot",
                season: 1,
                number: 1,
                summary: "Pilot episode.",
                image: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg"),
        Episode(id: 2,
                name: "Pilot",
                season: 1,
                number: 1,
                summary: "Pilot episode.",
                image: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg"),
        Episode(id: 3,
                name: "Pilot",
                season: 1,
                number: 1,
                summary: "Pilot episode.",
                image: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg")
    ]
    List(episodes) { episode in
        EpisodeCardView(episode: episode)
    }
    .listStyle(.plain)
}
