//
//  FetchEpisodesUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

// MARK: - Test Suite Configuration
@Suite("Fetch Episodes Use Case Tests")
struct FetchEpisodesUseCaseTests {
    var service: NetworkServiceProtocol!
    var mockService: MockNetworkService!

    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Use Case Tests
    @Test("Use case successfully executes episodes fetch")
    func testUseCaseSuccess() async throws {
        // Given
        let useCase = FetchEpisodesUseCase(networkService: mockService)
        let expectedSeries = [MockEpisode.mockEpisode()]
        mockService.requestResponse = .success(expectedSeries)

        // When
        let series = try await useCase.execute(seriesId: 1)

        // Then
        #expect(series.count == expectedSeries.count)
        #expect(series[0].name == expectedSeries[0].name)
    }
}
