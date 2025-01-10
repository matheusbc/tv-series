//
//  EpisodesListView.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI

struct EpisodesListView: View {
    @StateObject var viewModel: EpisodesListViewModel

    var body: some View {
        VStack {
            Text("Episodes")
                .font(.title2.bold())
                .padding(.bottom, 10)
            if viewModel.hasError {
                ListLoadingErrorView {
                    await viewModel.refreshEpisodes()
                }
                .padding(.top, 10)
            } else {
                Picker("", selection: self.$viewModel.selectedSeason) {
                    ForEach(self.viewModel.seasonOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                List(self.viewModel.filteredEpisodes) { episode in
                    NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                        EpisodeCardView(episode: episode)
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            Task {
                await viewModel.refreshEpisodes()
            }
        }
    }
}

#Preview {
    NavigationView {
        EpisodesListView(viewModel: EpisodesListViewModel(seriesId: 1))
    }
}
