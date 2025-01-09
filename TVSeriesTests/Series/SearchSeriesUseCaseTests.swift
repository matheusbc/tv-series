//
//  SearchSeriesUseCaseTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 09/01/25.
//
import Testing
import Foundation
@testable import TVSeries

@Suite("Search Series Use Case Tests")
struct SearchSeriesUseCaseTests {
    // MARK: - Private properties
    private var service: NetworkServiceProtocol!
    private var mockService: MockNetworkService!

    // MARK: - Initializers (setup)
    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Tests
    @Test("Use case successfully executes series search")
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
