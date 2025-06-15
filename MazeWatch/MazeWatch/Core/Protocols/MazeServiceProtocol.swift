//
//  MazeServiceProtocol.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

protocol MazeServiceProtocol {
    func fetchShows(page: Int) async throws -> [Show]
    func fetchShowDetail(id: Int) async throws -> Show
    func fetchSeasons(for showID: Int) async throws -> [Season]
    func fetchEpisodes(for seasonID: Int) async throws -> [Episode]
    func search(query: String) async throws -> [SearchResult]
}
