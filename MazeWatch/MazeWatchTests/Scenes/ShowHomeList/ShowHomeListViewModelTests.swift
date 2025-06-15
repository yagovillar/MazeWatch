//
//  ShowHomeListViewModelTests.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import XCTest
@testable import MazeWatch

final class HomeListViewModelTests: XCTestCase {
    
    var viewModel: HomeListViewModelProtocol!
    var serviceMock: MazeServiceMock!

    override func setUp() {
        super.setUp()
        serviceMock = MazeServiceMock()
        viewModel = HomeListViewModel(homeListService: serviceMock)
    }

    func testFetchShowsSuccess() async throws {
        // Arrange
        let mockShows = [Show.fixture(id: 1), Show.fixture(id: 2)]
        serviceMock.showsToReturn = mockShows

        let expectation = expectation(description: "Delegate didLoadShows called")
        let delegate = HomeDelegateSpy()
        viewModel.delegate = delegate
        delegate.expectation = expectation

        // Act
        viewModel.fetchShows()

        // Wait for delegate callback
        await waitForExpectations(timeout: 1.0)

        // Assert — só depois da atualização
        XCTAssertEqual(viewModel.getShowCount(), mockShows.count)
        XCTAssertEqual(viewModel.getShow(at: 0).id, mockShows[0].id)
        XCTAssertEqual(viewModel.getShow(at: 1).id, mockShows[1].id)
    }

    func testFetchShowsFailure() async {
        // Arrange
        serviceMock.shouldThrowError = true
        let delegate = HomeDelegateSpy()
        viewModel.delegate = delegate
        
        // Expectation inverted, delegate should NOT be called on error
        let expectation = expectation(description: "Delegate should NOT be called on error")
        expectation.isInverted = true
        delegate.expectation = expectation

        // Act
        await viewModel.fetchShows()

        // Assert
        XCTAssertEqual(viewModel.getShowCount(), 0)
        
        await waitForExpectations(timeout: 0.5)
    }
}

// Delegate spy to test delegate callback
class HomeDelegateSpy: HomeListViewModelDelegate {
    var expectation: XCTestExpectation?

    func didLoadShows() {
        expectation?.fulfill()
    }
}
