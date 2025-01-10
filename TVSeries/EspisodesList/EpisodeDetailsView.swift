//
//  EpisodeDetailsView.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI
import Kingfisher

struct EpisodeDetailsView: View {
    @State var episode: Episode
    @State var titleVisible: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.largeTitle.bold())
                    .onScrollVisibilityChange { isVisible in
                        titleVisible = isVisible
                    }
                KFImage(URL(string: episode.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: .zero, maxWidth: .infinity)
                HStack {
                    Text("Season \(episode.season)")
                        .font(.title2)
                    //                Text(String(episode.season))
                    //                    .font(.subheadline)
                    Text(" - ")
                    Text("Episode \(episode.number)")
                        .font(.title2)
                    //                Text(String(episode.number))
                    //                    .font(.subheadline)
                }
                .padding(.bottom, 10)
                Text("Summary")
                    .font(.title2.bold())
                HTMLText(htmlString: episode.summary, font: .callout)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(titleVisible ? "" : episode.name)
    }
}

#Preview {
    let episode = Episode(id: 1,
                          name: "Pilot",
                          season: 1,
                          number: 1,
                          summary: "Pilot episode.",
                          image: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg")
    NavigationView {
        EpisodeDetailsView(episode: episode)
    }
}
