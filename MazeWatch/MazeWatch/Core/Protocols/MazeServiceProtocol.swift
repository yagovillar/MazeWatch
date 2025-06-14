//
//  MazeServiceProtocol.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

protocol MazeServiceProtocol {
    func fetchShows(page: Int, completion: @escaping (Result<[Show], Error>) -> Void)
    func fetchShowDetail(id: Int, completion: @escaping (Result<Show, Error>) -> Void)
    func fetchSeasons(for showID: Int, completion: @escaping (Result<[Season], Error>) -> Void)
    func fetchEpisodes(for seasonID: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
}
