//
//  Search.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

struct ShowSearchItem: Codable {
    let score: Double
    let show: Show
}

struct PersonSearchItem: Codable {
    let score: Double
    let person: Person
}

struct SearchResult {
    let score: Double
    let item: SearchRepresentable
    let type: ItemType
}

protocol SearchRepresentable: Codable {
    var id: Int { get }
    var name: String { get }
    var image: ShowImage? { get }
}

enum ItemType: String, Codable {
    case person
    case show
}

