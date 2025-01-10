//
//  SeriesInfoView.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI

struct SeriesInfoView: View {
    var series: Series
    @State var title: String = ""

    var body: some View {
        TabView {
            SeriesDetailsView(series: series, title: $title)
                .tabItem {
                    Text("Info")
                }

            EpisodesListView(viewModel: EpisodesListViewModel(seriesId: series.id))
                .tabItem {
                    Text("Episodes")
                        .font(.title)
                }
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
    }
}
