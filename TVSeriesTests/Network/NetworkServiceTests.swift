//
//  NetworkServiceTests.swift
//  TVSeries
//
//  Created by Matheus Campos on 08/01/25.
//
import Testing
import Foundation
@testable import TVSeries

@Suite("Network Service Tests")
struct NetworkServiceTests {
    // MARK: - Private properties
    private var service: NetworkServiceProtocol!
    private var mockService: MockNetworkService!

    // MARK: - Initializers (setup)
    init() async throws {
        service = NetworkService()
        mockService = MockNetworkService()
    }

    // MARK: - Tests
    @Test("Network Service successfully fetches and decodes TV Series")
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

        // Then
        await #expect(throws: NetworkError.invalidURL) {
            // When
            let _: [Series] = try await service.request(testEndpoint)
        }
    }
}
