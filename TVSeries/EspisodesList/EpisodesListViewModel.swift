//
//  EpisodesListViewModel.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import Combine
import Foundation

protocol EpisodesListViewModelProtocol: ObservableObject {
    var episodes: [Episode] { get }
    var hasError: Bool { get }
    func refreshEpisodes() async
    func loadEpisodes() async
}

class EpisodesListViewModel: EpisodesListViewModelProtocol {
    @Published var episodes: [Episode] = []
    @Published var filteredEpisodes: [Episode] = []
    @Published var hasError: Bool = false
    @Published var selectedSeason: String = "1"
    @Published var seasonOptions: [String] = []
    var seriesId: Int

    private let fetchEpisodesUseCase: FetchEpisodesUseCaseProtocol = FetchEpisodesUseCase()
    private var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init(seriesId: Int) {
        self.seriesId = seriesId

        configureSeasonSelection()
    }

    func refreshEpisodes() async {
        await MainActor.run { [weak self] in
            self?.hasError = false
        }
        await loadEpisodes()
    }

    func loadEpisodes() async {
        guard !self.isLoading, self.episodes.isEmpty else { return }
        self.isLoading = true
        do {
            let episodes = try await self.fetchEpisodesUseCase.execute(seriesId: self.seriesId)
            await MainActor.run {
                self.episodes = episodes.map { $0.parse() }
                let seasonId = Int(self.selectedSeason) ?? 1
                self.filteredEpisodes = self.episodes.filter { $0.season == seasonId }

                let seasons: [Int] = Array(1...self.episodes.reduce(1, { $1.season > $0 ? $1.season : $0 }))
                self.seasonOptions = seasons.map { String($0) }
                self.isLoading = false
            }
        } catch {
            await self.showError()
        }
    }

    @MainActor
    private func showError() {
        self.hasError = self.episodes.count == 0
        self.isLoading = false
    }

    private func configureSeasonSelection() {
        $selectedSeason
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] season in
                let seasonId = Int(season) ?? 1
                Task {
                    await self?.filterEpisodes(bySeason: seasonId)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func filterEpisodes(bySeason seasonId: Int) {
        self.filteredEpisodes = self.episodes.filter { $0.season == seasonId }
    }
}
