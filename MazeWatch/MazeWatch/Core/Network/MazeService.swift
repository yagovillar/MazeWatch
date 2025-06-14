//
//  MazeService.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

class MazeService: MazeServiceProtocol {
    private let client: NetworkClient
    
    init(client: NetworkClient = MazeNetworkClient()) {
        self.client = client
    }

    func fetchShows(page: Int, completion: @escaping (Result<[Show], Error>) -> Void) {
        client.request(MazeAPI.list(page: page), completion: completion)
    }
    
    func fetchShowDetail(id: Int, completion: @escaping (Result<Show, Error>) -> Void) {
        client.request(MazeAPI.detail(id: id), completion: completion)
    }
    
    func fetchSeasons(for showID: Int, completion: @escaping (Result<[Season], Error>) -> Void) {
        client.request(MazeAPI.seasons(showID: showID), completion: completion)
    }
    
    func fetchEpisodes(for seasonID: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        client.request(MazeAPI.episodes(seasonID: seasonID), completion: completion)
    }
}
