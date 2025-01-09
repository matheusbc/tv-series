//
//  FetchEpisodeUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

@Suite("Fetch Episode Use Case Tests")
struct FetchEpisodeUseCaseTests {
    // MARK: - Private properties
    private var service: NetworkServiceProtocol!
    private var mockService: MockNetworkService!

    // MARK: - Initializers (setup)
    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Tests
    @Test("Use case successfully executes episode fetch")
    func testUseCaseSuccess() async throws {
        // Given
        let useCase = FetchEpisodeUseCase(networkService: mockService)
        let expectedSeries = MockEpisode.mockEpisode()
        mockService.requestResponse = .success(expectedSeries)

        // When
        let series = try await useCase.execute(seriesId: 1, season: 1, episode: 1)

        // Then
        #expect(series.name == expectedSeries.name)
    }
}
