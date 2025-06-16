//
//  Seasons.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

struct Season: Codable {
    let id: Int
    let url: String
    let number: Int?
    let name: String?
    let episodeOrder: Int?
    let premiereDate: String?
    let endDate: String?
    let network: Channel?
    let webChannel: Channel?
    let image: ShowImage?
    let summary: String?
    let links: Links?
    // Remover ou deixar opcional pois não vem no JSON
    var episodes: [Episode]?

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, webChannel, image, summary
        case links = "_links"
        case episodes
    }
}

struct Channel: Codable {
    let id: Int
    let name: String
    let country: Country?
    let officialSite: String?
}

struct Links: Codable {
    let selfLink: Link

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}

struct Link: Codable {
    let href: String
}
