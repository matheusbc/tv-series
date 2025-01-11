//
//  FetchSeriesDetailsUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

@Suite("Fetch Series Details Use Case Tests")
struct FetchSeriesDetailsUseCaseTests {
    // MARK: - Private properties
    private var service: NetworkServiceProtocol!
    private var mockService: MockNetworkService!

    // MARK: - Initializers (setup)
    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Tests
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
