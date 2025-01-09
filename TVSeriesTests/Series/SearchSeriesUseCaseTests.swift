//
//  SearchSeriesUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

// MARK: - Test Suite Configuration
@Suite("Search Series Use Case Tests")
struct SearchSeriesUseCaseTests {
    var service: NetworkServiceProtocol!
    var mockService: MockNetworkService!

    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Use Case Tests
    @Test("Use case successfully executes user fetch")
    func testUseCaseSuccess() async throws {
        // Given
        let useCase = SearchSeriesUseCase(networkService: mockService)
        let expectedSeries = [MockSeries.mockSeries()]
        mockService.requestResponse = .success(expectedSeries)

        // When
        let series = try await useCase.execute()

        // Then
        #expect(series.count == expectedSeries.count)
        #expect(series[0].name == expectedSeries[0].name)
    }
}
