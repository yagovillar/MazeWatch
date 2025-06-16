//
//  SearchShowsViewModelTests.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

import XCTest
@testable import MazeWatch

final class SearchShowsViewModelTests: XCTestCase {

    var viewModel: SearchShowsViewModel!
    var serviceMock: MazeServiceMock!
    var delegateSpy: DelegateSpy!

    override func setUp() {
        super.setUp()
        serviceMock = MazeServiceMock()
        viewModel = SearchShowsViewModel(service: serviceMock)
        delegateSpy = DelegateSpy()
        viewModel.delegate = delegateSpy
    }

    override func tearDown() {
        viewModel = nil
        serviceMock = nil
        delegateSpy = nil
        super.tearDown()
    }

    func testSearchWithResults() async {
        // Arrange
        let showResult = SearchResult.fixture()
        let personResult = SearchResult.fixture(item: Person.fixture(), type: .person)
        serviceMock.searchResultsToReturn = [showResult, personResult]

        let expectation = expectation(description: "Delegate should receive results")

        delegateSpy.expectation = expectation

        // Act
        await viewModel.search(query: "Test")

        // Assert
        await waitForExpectations(timeout: 1)
        if case .results(let results) = delegateSpy.lastState {
            XCTAssertEqual(results.count, 2)
            XCTAssertEqual(viewModel.getItensCount(), 2)
            XCTAssertEqual(results[0].type, .show)
            XCTAssertEqual(results[1].type, .person)
        } else {
            XCTFail("Expected results state")
        }
    }

    func testSearchNoResult() async {
        // Arrange
        serviceMock.searchResultsToReturn = [] // retorna vazio para simular "no results"
        let expectation = expectation(description: "Delegate receives error state")
        
        var receivedState: SearchState?
        let delegate = DelegateSpy { state in
            receivedState = state
            if case .error = state {
                expectation.fulfill()
            }
        }
        viewModel.delegate = delegate

        // Act
        await viewModel.search(query: "nonexistentquery")

        // Assert
        await waitForExpectations(timeout: 1)

        guard let state = receivedState else {
            XCTFail("Nenhum estado recebido")
            return
        }

        if case .error(let mazeError) = state {
            if case .noResults = mazeError {
                // sucesso: erro esperado
            } else {
                XCTFail("Esperava erro .noResults, mas recebeu \(mazeError)")
            }
        } else {
            XCTFail("Esperava estado .error, mas recebeu \(state)")
        }
    }
    
    func testClearResults() {
        // Arrange
        // Simula resultados no resultsModel (usando o serviceMock e chamando search, ou configurando diretamente se possível)
        serviceMock.searchResultsToReturn = [SearchResult.fixture()]
        let expectation = expectation(description: "Delegate receives idle state after clearing")
        
        let delegate = DelegateSpy { state in
            if case .idle = state {
                expectation.fulfill()
            }
        }
        viewModel.delegate = delegate

        // Simula uma busca para popular os resultados
        Task {
            await viewModel.search(query: "some query")
            // Act
            viewModel.clearResults()
            // Assert
            XCTAssertEqual(viewModel.getItensCount(), 0)
        }

        wait(for: [expectation], timeout: 1)
    }
}

// Delegate spy to capture delegate calls
class DelegateSpy: SearchViewModelDelegate {
    var expectation: XCTestExpectation?
    var lastState: SearchState?
    private var didUpdateStateHandler: ((SearchState) -> Void)?
    private var fulfilled = false

    init(onUpdate: ((SearchState) -> Void)? = nil) {
        self.didUpdateStateHandler = onUpdate
    }

    func didUpdateState(_ state: SearchState) {
        lastState = state
        if !fulfilled {
            expectation?.fulfill()
            fulfilled = true
        }
        didUpdateStateHandler?(state)
    }
}
