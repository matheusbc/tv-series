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
    var hasNextPage: Bool { get }
    var hasError: Bool { get }
    func refreshSeries() async
    func loadSeries() async
}

class SeriesListViewModel: SeriesListViewModelProtocol {
    @Published var series: [Series] = []
    @Published var filteredSeries: [Series] = []
    @Published var searchText: String = ""
    @Published var hasNextPage: Bool = true
    @Published var hasError: Bool = false

    private let fetchSeriesUseCase: FetchSeriesUseCaseProtocol = FetchSeriesUseCase()
    private let searchSeriesUseCase: SearchSeriesUseCaseProtocol = SearchSeriesUseCase()
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        configureSearch()
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
                self.series.append(contentsOf: series.map { $0.parse() })
                self.filteredSeries = self.series
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
        } catch {
            await self.showError()
        }
    }

    @MainActor
    private func showError() {
        self.hasError = self.series.count == 0
        self.isLoading = false
    }

    private func configureSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                if searchText.isEmpty {
                    self?.filteredSeries = self?.series ?? []
                    return
                }
                self?.filteredSeries.removeAll()
                self?.hasNextPage = false
                Task {
                    await self?.searchSeries()
                }
            }
            .store(in: &cancellables)
    }

    private func searchSeries() async {
        do {
            let series = try await self.searchSeriesUseCase.execute(query: self.searchText)
            await MainActor.run {
                self.filteredSeries = series.map { $0.parse() }
            }
        } catch {
            await self.showError()
        }
    }
}
