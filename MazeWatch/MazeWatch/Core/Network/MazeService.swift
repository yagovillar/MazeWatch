//
//  MazeService.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

final class MazeService: MazeServiceProtocol {

    private let client: NetworkClient

    init(client: NetworkClient = MazeNetworkClient()) {
        self.client = client
    }

    func fetchShows(page: Int) async throws -> [Show] {
        do {
            return try await client.request(MazeAPI.list(page: page))
        } catch {
            GlobalErrorHandler.shared.showError(error.localizedDescription)
            throw error
        }
    }

    func fetchShowDetail(id: Int) async throws -> ShowDetails {
        do {
            return try await client.request(MazeAPI.detail(id: id))
        } catch {
            GlobalErrorHandler.shared.showError(error.localizedDescription)
            throw error
        }
    }

    func fetchSeasons(for showID: Int) async throws -> [Season] {
        do {
            return try await client.request(MazeAPI.seasons(showID: showID))
        } catch {
            GlobalErrorHandler.shared.showError(error.localizedDescription)
            throw error
        }
    }

    func fetchEpisodes(for seasonID: Int) async throws -> [Episode] {
        do {
            return try await client.request(MazeAPI.episodes(seasonID: seasonID))
        } catch {
            GlobalErrorHandler.shared.showError(error.localizedDescription)
            throw error
        }
    }

    func search(query: String) async throws -> [SearchResult] {
        do {
            async let showItems: [ShowSearchItem] = client.request(MazeAPI.searchShows(query: query))
            async let personItems: [PersonSearchItem] = client.request(MazeAPI.searchPersons(query: query))

            let (shows, persons) = try await (showItems, personItems)

            let showResults = shows.map {
                SearchResult(score: $0.score, item: $0.show, type: .show)
            }
            let personResults = persons.map {
                SearchResult(score: $0.score, item: $0.person, type: .person)
            }

            return showResults + personResults
        } catch {
            GlobalErrorHandler.shared.showError(error.localizedDescription)
            throw error
        }
    }

}
