//
//  FetchSeriesUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

// MARK: - Test Suite Configuration
@Suite("Fetch Series Use Case Tests")
struct FetchSeriesUseCaseTests {
    var service: NetworkServiceProtocol!
    var mockService: MockNetworkService!

    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Use Case Tests
    @Test("Use case successfully executes series fetch")
    func testUseCaseSuccess() async throws {
        // Given
        let useCase = FetchSeriesUseCase(networkService: mockService)
        let expectedSeries = [MockSeries.mockSeries()]
        mockService.requestResponse = .success(expectedSeries)

        // When
        let series = try await useCase.execute()

        // Then
        #expect(series.count == expectedSeries.count)
        #expect(series[0].name == expectedSeries[0].name)
    }
}
