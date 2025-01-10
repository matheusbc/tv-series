//
//  SeriesListViewModel.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import Combine
import Foundation

protocol SeriesListViewModelProtocol: ObservableObject {
    var series: [Series] { get }
    var filteredSeries: [Series] { get }
    var searchText: String { get set }
    var error: Error? { get }
    var hasNextPage: Bool { get }
    var hasError: Bool { get }
    func refreshSeries() async
    func loadSeries() async
}

class SeriesListViewModel: SeriesListViewModelProtocol {
    @Published var series: [Series]
    @Published var filteredSeries: [Series]
    @Published var searchText: String
    @Published var error: Error?
    @Published var hasNextPage: Bool
    @Published var hasError: Bool

    private let fetchSeriesUseCase: FetchSeriesUseCaseProtocol
    private var currentPage: Int
    private var isLoading: Bool

    init() {
        self.series = []
        self.filteredSeries = []
        self.searchText = ""
        self.hasNextPage = true
        self.hasError = false
        self.fetchSeriesUseCase = FetchSeriesUseCase()
        self.currentPage = 0
        self.isLoading = false
    }

    func refreshSeries() async {
        await MainActor.run {
            self.series.removeAll()
            self.hasNextPage = true
            self.hasError = false
        }
        self.currentPage = 0
        await loadSeries()
    }

    func loadSeries() async {
        guard !self.isLoading else { return }
        self.isLoading = true
        do {
            let series = try await self.fetchSeriesUseCase.execute(page: self.currentPage)
            await MainActor.run {
                self.series.append(contentsOf: series)
                self.isLoading = false
            }
            self.currentPage += 1
        } catch let error as NetworkError {
            if case NetworkError.notFound = error {
                await MainActor.run {
                    self.hasNextPage = false
                }
            } else {
                await self.showError()
            }
        } catch let error {
            await self.showError()
        }
    }

    @MainActor
    private func showError() {
        self.hasError = self.series.count == 0
    }
}
