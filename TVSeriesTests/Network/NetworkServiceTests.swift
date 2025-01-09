//
//  NetworkServiceTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//
import Testing
import Foundation
@testable import TVSeries

// MARK: - Test Suite Configuration
@Suite("Network Service Tests")
struct NetworkServiceTests {
    var service: NetworkServiceProtocol!
    var mockService: MockNetworkService!

    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Network Service Tests
    @Test("Network Service successfully fetches and decodes user")
    func testNetworkServiceSuccess() async throws {
        // Given
        let expectedSeries = [MockSeries.mockSeries()]
        mockService.requestResponse = .success(expectedSeries)

        // When
        let result: [Series] = try await mockService.request(SeriesEndpoints.getSeriesList(page: 0))

        // Then
        #expect(result.count > 0)
        #expect(result.count == expectedSeries.count)
        #expect(result[0].name == expectedSeries[0].name)
    }

    @Test("Network Service throws error for invalid URL")
    func testNetworkServiceInvalidURL() async throws {
        // Given
        let testEndpoint = TestEndpoints.invalidURL

        // When/Then
        await #expect(throws: NetworkError.invalidURL) {
            let _: [Series] = try await service.request(testEndpoint)
        }
    }

    // MARK: - Use Case Tests
    @Test("Use case successfully executes user fetch")
    func testUseCaseSuccess() async throws {
        // Given
        let mockService = MockNetworkService()
        let useCase = FetchSeriesDetailsUseCase(networkService: mockService)
        let expectedSeries = MockSeries.mockSeries()
        mockService.requestResponse = .success(expectedSeries)

        // When
        let series = try await useCase.execute(seriesId: 1)

        // Then
        #expect(series.name == expectedSeries.name)
    }
}
