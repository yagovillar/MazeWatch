//
//  Episodes.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

struct Episode: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let season: Int?
    let number: Int?
    let type: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let rating: Rating?
    let image: ShowImage?
    let summary: String?
}

extension Episode {
    static let mockList: [Episode] = [
        Episode(
            id: 1, url: "", name: "Pilot", season: 1, number: 1, type: "Regular",
            airdate: "2025-06-01", airtime: "20:00", airstamp: "2025-06-01T20:00:00Z",
            runtime: 42, rating: Rating(average: 8.5),
            image: ShowImage(medium: "", original: ""),
            summary: "Series debut."
        ),
        Episode(
            id: 2, url: "", name: "Second Episode", season: 1, number: 2, type: "Regular",
            airdate: "2025-06-08", airtime: "20:00", airstamp: "2025-06-08T20:00:00Z",
            runtime: 45, rating: Rating(average: 8.7),
            image: ShowImage(medium: "", original: ""),
            summary: "The story continues."
        ),
        Episode(
            id: 3, url: "", name: "Mid Season Finale", season: 1, number: 3, type: "Regular",
            airdate: "2025-06-15", airtime: "20:00", airstamp: "2025-06-15T20:00:00Z",
            runtime: 50, rating: Rating(average: 9.0),
            image: ShowImage(medium: "", original: ""),
            summary: "Cliffhanger!"
        )
    ]
}
