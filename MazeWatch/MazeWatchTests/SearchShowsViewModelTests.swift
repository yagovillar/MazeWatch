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
        let expectedResults = [SearchResult(score: 1.0, item: Show(id: 1, name: "Test Show"), type: .show)]
        mockService.mockResults = expectedResults
        
        // When
        sut.search(query: "test")
        
        // Then
        await fulfillment(of: [mockDelegate.expectation], timeout: 1.0)
        XCTAssertEqual(sut.getShowsCount(), 1)
        XCTAssertEqual(mockDelegate.lastState, .results(expectedResults))
    }
    
    func testSearchEmptyQuery() {
        // When
        sut.search(query: "   ")
        
        // Then
        XCTAssertEqual(sut.getShowsCount(), 0)
        XCTAssertEqual(mockDelegate.lastState, .idle)
    }
    
    func testSearchError() async {
        // Given
        mockService.shouldFail = true
        
        // When
        sut.search(query: "test")
        
        // Then
        await fulfillment(of: [mockDelegate.expectation], timeout: 1.0)
        XCTAssertEqual(sut.getShowsCount(), 0)
        if case .error = mockDelegate.lastState {
            // Success
        } else {
            XCTFail("Expected error state")
        }
    }
}

// MARK: - Mocks

class MockMazeService: MazeServiceProtocol {
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