//
//  ShowDetailsViewModelTests.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 16/06/25.
//


import XCTest
@testable import MazeWatch

final class ShowDetailsViewModelTests: XCTestCase {
    var sut: ShowDetailsViewModel!
    var serviceMock: DetailsMazeServiceMock!
    var modelMock: DetailsManagerMock!
    var delegateMock: ViewModelDelegateMock!
    var coordinatorMock: HomeListCoordinatorDelegateMock!

    override func setUp() {
        super.setUp()
        serviceMock = DetailsMazeServiceMock()
        modelMock = DetailsManagerMock()
        delegateMock = ViewModelDelegateMock()
        coordinatorMock = HomeListCoordinatorDelegateMock()

        sut = ShowDetailsViewModel(service: serviceMock, model: modelMock, delegate: delegateMock)
        sut.coordinatorDelegate = coordinatorMock
    }

    override func tearDown() {
        sut = nil
        serviceMock = nil
        modelMock = nil
        delegateMock = nil
        coordinatorMock = nil
        super.tearDown()
    }

    func test_fetchShowDetails_success_shouldSetDetailsAndNotifyDelegate() async {
        // Given
        let season = Season.fixture()
        let episodes = [Episode.fixture()]
        let showDetails = ShowDetails.fixture(seasons: [season])

        serviceMock.seasonsToReturn = [season]
        serviceMock.episodesToReturn = episodes
        serviceMock.detailsToReturn = showDetails

        // When
        await sut.fetchShowDetails()

        // Then
        XCTAssertEqual(modelMock.setDetailsCalledWith?.id, showDetails.id)
        XCTAssertEqual(modelMock.setEpisodesListCalledWith, season.id)
        XCTAssertTrue(delegateMock.didGetDetailsCalled)
    }

    func test_selectSeason_shouldUpdateModelAndNotifyDelegate() {
        // When
        sut.selectSeason(3)

        // Then
        XCTAssertEqual(modelMock.setEpisodesListCalledWith, 3)
        XCTAssertTrue(delegateMock.didSelectSeasonCalled)
    }

    func test_getEpisodesCount_shouldReturnCorrectCount() {
        // Given
        modelMock.episodes = [Episode.fixture()]

        // When & Then
        XCTAssertEqual(sut.getEpisodesCount(), 1)
    }

    func test_getEpisode_shouldReturnCorrectEpisode() {
        // Given
        let episode = Episode.fixture()
        modelMock.episodes = [episode]

        // When & Then
        XCTAssertEqual(sut.getEpisode(at: 0)?.id, episode.id)
    }

    func test_selectEpisode_shouldNotifyCoordinator() {
        // Given
        let episode = Episode.fixture()
        modelMock.episodes = [episode]

        // When
        sut.selectEpisode(episode: 0)

        // Then
        XCTAssertEqual(coordinatorMock.selectedEpisode?.episode.id, episode.id)
        XCTAssertEqual(coordinatorMock.selectedEpisode?.show.id, modelMock.details.id)
    }
}
