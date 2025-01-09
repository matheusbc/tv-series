//
//  FetchSeriesDetailsUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

// MARK: - Test Suite Configuration
@Suite("Fetch Series Details Use Case Tests")
struct FetchSeriesDetailsUseCaseTests {
    var service: NetworkServiceProtocol!
    var mockService: MockNetworkService!

    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Use Case Tests
    @Test("Use case successfully executes series details fetch")
    func testUseCaseSuccess() async throws {
        // Given
        let useCase = FetchSeriesDetailsUseCase(networkService: mockService)
        let expectedSeries = MockSeries.mockSeries()
        mockService.requestResponse = .success(expectedSeries)

        // When
        let series = try await useCase.execute(seriesId: 1)

        // Then
        #expect(series.name == expectedSeries.name)
    }
}
