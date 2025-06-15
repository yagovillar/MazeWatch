//
//  Person.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
struct PersonSearchResult: Codable {
    let score: Double
    let person: Person
}

struct Person: Codable, SearchRepresentable {
    let id: Int
    let url: String
    let name: String
    let country: Country?      // optional because country can be null
    let birthday: String?      // optional for null value
    let deathday: String?      // optional
    let gender: String?
    let image: ShowImage?
}
