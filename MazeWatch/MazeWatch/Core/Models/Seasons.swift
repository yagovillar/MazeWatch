//
//  Seasons.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation

struct Season: Codable {
    let id: Int
    let url: String
    let number: Int?
    let name: String?
    let episodeOrder: Int?
    let premiereDate: String?
    let endDate: String?
    let network: Network?
    let webChannel: Channel?
    let image: ShowImage?
    let summary: String?
    let links: Link?
    let episodes: [Episode]

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, webChannel, image, summary, episodes
        case links = "_links"
    }
}

struct Channel: Codable {
    let id: Int
    let name: String
    let country: Country?
}

struct Link: Codable {
    let href: String
}
