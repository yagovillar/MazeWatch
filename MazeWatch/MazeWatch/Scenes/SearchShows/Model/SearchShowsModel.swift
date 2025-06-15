//
//  SearchShowsModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

import Foundation

protocol ShowResultsManaging: AnyObject {
    var shows: [Show] { get }
    var count: Int { get }
    var onChange: (() -> Void)? { get set }

    func update(with results: [Show])
    func clear()
    func show(at index: Int) -> Show?
}

final class SearchShowsModel: ShowResultsManaging{

    // MARK: - Properties

    private(set) var shows: [Show] = []
    var onChange: (() -> Void)?

    // MARK: - Public Methods

    func update(with results: [Show]) {
        self.shows = results
        onChange?()
    }

    func clear() {
        self.shows = []
        onChange?()
    }

    func show(at index: Int) -> Show? {
        guard index >= 0 && index < shows.count else { return nil }
        return shows[index]
    }

    var count: Int {
        shows.count
    }
}

