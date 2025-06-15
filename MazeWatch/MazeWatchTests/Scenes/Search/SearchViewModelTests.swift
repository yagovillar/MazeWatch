import XCTest
@testable import MazeWatch

final class SearchShowsViewModelTests: XCTestCase {
    var sut: SearchShowsViewModel!
    var mockService: MockMazeService!
    var mockDelegate: MockSearchViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockMazeService()
        mockDelegate = MockSearchViewModelDelegate()
        sut = SearchShowsViewModel(service: mockService)
        sut.delegate = mockDelegate
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testSearchSuccess() async {
        // Given
        let expectedResults = [SearchResult(score: 1.0, item: Show(id: 1, name: "Test Show", image: nil, summary: nil), type: .show)]
        mockService.mockResults = expectedResults

        // When
        sut.search(query: "test")

        // Then
        await fulfillment(of: [mockDelegate.expectation], timeout: 1.0)
        XCTAssertEqual(sut.getItensCount(), 1)

        if case .results(let results) = mockDelegate.lastState {
            XCTAssertEqual(results.count, expectedResults.count)
            XCTAssertEqual(results.first?.score, expectedResults.first?.score)
            XCTAssertEqual(results.first?.type, expectedResults.first?.type)
            XCTAssertEqual((results.first?.item as? Show)?.id, (expectedResults.first?.item as? Show)?.id)
            XCTAssertEqual((results.first?.item as? Show)?.name, (expectedResults.first?.item as? Show)?.name)
        } else {
            XCTFail("Expected results state")
        }
    }

    func testSearchEmptyQuery() {
        // When
        sut.search(query: "   ")

        // Then
        XCTAssertEqual(sut.getItensCount(), 0)
        if case .idle = mockDelegate.lastState {
            // Success
        } else {
            XCTFail("Expected idle state")
        }
    }

    func testSearchError() async {
        // Given
        mockService.shouldFail = true

        // When
        sut.search(query: "test")

        // Then
        await fulfillment(of: [mockDelegate.expectation], timeout: 1.0)
        XCTAssertEqual(sut.getItensCount(), 0)

        if case .error = mockDelegate.lastState {
            // Success
        } else {
            XCTFail("Expected error state")
        }
    }
}

// MARK: - Mocks

class MockMazeService: MazeServiceProtocol {
    func fetchShows(page: Int) async throws -> [MazeWatch.Show] {
        fatalError("Not implemented")
    }

    func fetchShowDetail(id: Int) async throws -> MazeWatch.Show {
        fatalError("Not implemented")
    }

    func fetchSeasons(for showID: Int) async throws -> [MazeWatch.Season] {
        fatalError("Not implemented")
    }

    func fetchEpisodes(for seasonID: Int) async throws -> [MazeWatch.Episode] {
        fatalError("Not implemented")
    }

    var mockResults: [SearchResult] = []
    var shouldFail = false

    func search(query: String) async throws -> [SearchResult] {
        if shouldFail {
            throw MazeError.networkError(NSError(domain: "", code: -1))
        }
        return mockResults
    }
}

class MockSearchViewModelDelegate: SearchViewModelDelegate {
    let expectation = XCTestExpectation(description: "State updated")
    var lastState: SearchState = .idle

    func didUpdateState(_ state: SearchState) {
        lastState = state
        expectation.fulfill()
    }
}
