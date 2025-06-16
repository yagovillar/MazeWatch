//
//  SearchFixtures.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import XCTest
@testable import MazeWatch
extension Person {
    static func fixture(
        id: Int = 1,
        url: String = "https://example.com/person",
        name: String = "Sample Person",
        country: Country? = Country(name: "USA", code: "US", timezone: "America/New_York"),
        birthday: String? = "1990-01-01",
        deathday: String? = nil,
        gender: String? = "Male",
        image: ShowImage? = ShowImage(medium: "https://example.com/person_medium.jpg", original: "https://example.com/person_original.jpg")
    ) -> Person {
        return Person(id: id, url: url, name: name, country: country, birthday: birthday, deathday: deathday, gender: gender, image: image)
    }
}

extension SearchResult {
    static func fixture(
        score: Double = 1.0,
        item: SearchRepresentable = Show.fixture(),
        type: ItemType = .show
    ) -> SearchResult {
        return SearchResult(score: score, item: item, type: type)
    }
}
