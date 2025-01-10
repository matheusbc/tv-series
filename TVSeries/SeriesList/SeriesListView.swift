//
//  SeriesListView.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import SwiftUI

struct SeriesListView: View {
    @StateObject var viewModel: SeriesListViewModel = SeriesListViewModel()

    var body: some View {
        VStack {
            if viewModel.hasError {
                Spacer()
                Text("Something went wrong")
                Button("Retry") {
                    Task {
                        await viewModel.refreshSeries()
                    }
                }
                Spacer()
            } else {
                List(self.viewModel.filteredSeries) { series in
                    SeriesCardView(series: series)
                    if self.viewModel.hasNextPage && self.viewModel.series.last?.id == series.id {
                        ProgressView()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .task {
                                await self.viewModel.loadSeries()
                            }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.refreshSeries()
                }
                .searchable(text: self.$viewModel.searchText)
            }
        }
        .task {
            await viewModel.refreshSeries()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("TV Series")
    }
}

#Preview {
    NavigationView {
        SeriesListView()
    }
}
