//
//  MazeServiceMock.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import XCTest
@testable import MazeWatch

final class MazeServiceMock: MazeServiceProtocol {
    func fetchShowDetail(id: Int) async throws -> MazeWatch.ShowDetails {
        return ShowDetails.fixture()
    }
    
    
    // MARK: - Properties to control behavior
    
    var showsToReturn: [Show] = []
    var showDetailToReturn: Show = Show.getEmptyShow()
    var seasonsToReturn: [Season] = []
    var episodesToReturn: [Episode] = []
    var searchResultsToReturn: [SearchResult] = []
    
    var shouldThrowError: Bool = false
    var errorToThrow: Error = NSError(domain: "MazeServiceMockError", code: -1, userInfo: nil)
    
    // MARK: - Tracking calls (Spying)
    
    private(set) var fetchShowsCalledWithPages: [Int] = []
    private(set) var fetchShowDetailCalledWithIds: [Int] = []
    private(set) var fetchSeasonsCalledWithShowIDs: [Int] = []
    private(set) var fetchEpisodesCalledWithSeasonIDs: [Int] = []
    private(set) var searchCalledWithQueries: [String] = []
    
    // MARK: - Protocol methods
    
    func fetchShows(page: Int) async throws -> [Show] {
        fetchShowsCalledWithPages.append(page)
        if shouldThrowError {
            throw errorToThrow
        }
        return showsToReturn
    }
    
    func fetchShowDetail(id: Int) async throws -> Show {
        fetchShowDetailCalledWithIds.append(id)
        if shouldThrowError {
            throw errorToThrow
        }
        return showDetailToReturn
    }
    
    func fetchSeasons(for showID: Int) async throws -> [Season] {
        fetchSeasonsCalledWithShowIDs.append(showID)
        if shouldThrowError {
            throw errorToThrow
        }
        return seasonsToReturn
    }
    
    func fetchEpisodes(for seasonID: Int) async throws -> [Episode] {
        fetchEpisodesCalledWithSeasonIDs.append(seasonID)
        if shouldThrowError {
            throw errorToThrow
        }
        return episodesToReturn
    }
    
    func search(query: String) async throws -> [SearchResult] {
        searchCalledWithQueries.append(query)
        if shouldThrowError {
            throw errorToThrow
        }
        return searchResultsToReturn
    }
    
    // MARK: - Helpers for tests
    
    func resetCalls() {
        fetchShowsCalledWithPages.removeAll()
        fetchShowDetailCalledWithIds.removeAll()
        fetchSeasonsCalledWithShowIDs.removeAll()
        fetchEpisodesCalledWithSeasonIDs.removeAll()
        searchCalledWithQueries.removeAll()
        
        showsToReturn.removeAll()
        seasonsToReturn.removeAll()
        episodesToReturn.removeAll()
        searchResultsToReturn.removeAll()
        
        shouldThrowError = false
        errorToThrow = NSError(domain: "MazeServiceMockError", code: -1, userInfo: nil)
        showDetailToReturn = Show.getEmptyShow()
    }
}
