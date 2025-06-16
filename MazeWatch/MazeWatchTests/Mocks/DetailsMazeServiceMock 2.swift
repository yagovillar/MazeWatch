//
//  DetailsMazeServiceMock 2.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 16/06/25.
//
import XCTest
@testable import MazeWatch

final class DetailsMazeServiceMock: MazeServiceProtocol {
    var seasonsToReturn: [Season] = []
    var episodesToReturn: [Episode] = []
    var detailsToReturn: ShowDetails = .fixture()
    var fetchSeasonsCalledWith: Int?
    var fetchEpisodesCalledWith: Int?
    var fetchShowDetailCalledWith: Int?

    func fetchShows(page: Int) async throws -> [Show] {
        return []
    }

    func fetchShowDetail(id: Int) async throws -> ShowDetails {
        fetchShowDetailCalledWith = id
        return detailsToReturn
    }

    func fetchSeasons(for showID: Int) async throws -> [Season] {
        fetchSeasonsCalledWith = showID
        return seasonsToReturn
    }

    func fetchEpisodes(for seasonID: Int) async throws -> [Episode] {
        fetchEpisodesCalledWith = seasonID
        return episodesToReturn
    }

    func search(query: String) async throws -> [SearchResult] {
        return []
    }
}

final class DetailsManagerMock: DetailsManagerProtocol {
    var details: ShowDetails = .fixture()
    var episodes: [Episode]? = []
    var setDetailsCalledWith: ShowDetails?
    var setEpisodesListCalledWith: Int?
    var id: Int? = 1
    var count: Int? {
        return episodes?.count
    }

    func getDetails() -> ShowDetails {
        return details
    }

    func setDetails(_ details: ShowDetails) {
        setDetailsCalledWith = details
        self.details = details
    }

    func getEpisodesList() -> [Episode]? {
        return episodes
    }

    func setEpisodesList(season: Int) {
        setEpisodesListCalledWith = season
    }
}

final class ViewModelDelegateMock: ShowDetailsViewModelDelegate {
    var didGetDetailsCalled = false
    var didSelectSeasonCalled = false

    func didGetDetaisl() {
        didGetDetailsCalled = true
    }

    func didSelectSeason() {
        didSelectSeasonCalled = true
    }
}

final class HomeListCoordinatorDelegateMock: HomeListCoordinatorDelegate {
    var selectedShowId: Int?
    var selectedEpisode: (episode: Episode, show: ShowDetails)?

    func didSelectShow(showId: Int) {
        selectedShowId = showId
    }

    func didSelectEpisode(episode: Episode, show: ShowDetails) {
        selectedEpisode = (episode, show)
    }
}
