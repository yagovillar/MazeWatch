//
//  Series.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation

struct SearchShowItem: Codable {
    let score: Double
    let show: Show
}

struct Show: Codable, SearchRepresentable {
    let id: Int
    let name: String
    let image: ShowImage?
    let summary: String?

    static func getEmptyShow() -> Show {
        return Show(id: 0, name: "", image: nil, summary: nil)
    }
}

extension Show {
    static let mockList: [Show] = [
        Show(id: 101, name: "Maze Adventures", image: ShowImage(medium: "", original: ""), summary: "First mock show."),
        Show(id: 102, name: "Mystery Maze", image: ShowImage(medium: "", original: ""), summary: "Second mock show."),
        Show(id: 103, name: "Watch the Maze", image: ShowImage(medium: "", original: ""), summary: "Third mock show.")
    ]
}

struct ShowDetails: Codable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String?
    let genres: [String]
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let image: ShowImage?
    let summary: String?
    var seasons: [Season]?
    
    static func getEmptyShowDetails() -> ShowDetails {
        return ShowDetails(id: 0, url: "", name: "", type: "", language: nil, genres: [],
                           status: nil, runtime: nil, averageRuntime: nil, premiered: nil,
                           officialSite: nil, schedule: Schedule(time: "", days: []),
                           rating: nil, weight: nil, network: nil, image: nil, summary: nil, seasons: nil)
    }
}

struct Schedule: Codable {
    let time: String
    let days: [String]
}

struct Rating: Codable {
    let average: Double?
}

struct Network: Codable {
    let id: Int
    let name: String
    let country: Country?
}

struct Country: Codable {
    let name: String
    let code: String
    let timezone: String
}

struct ShowImage: Codable {
    let medium: String?
    let original: String?
}
