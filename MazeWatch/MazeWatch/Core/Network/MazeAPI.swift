//
//  MazeAPI.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation

enum MazeAPI {
    case list(page: Int)
    case detail(id: Int)
    case seasons(showID: Int)
    case episodes(seasonID: Int)
    case searchShows(query: String)
    case searchPersons(query: String)
}

extension MazeAPI: Endpoint {
    var baseURL: String { "https://api.tvmaze.com" }

    var path: String {
        switch self {
        case .list:
            return "/shows"
        case .detail(let id):
            return "/shows/\(id)"
        case .seasons(let showID):
            return "/shows/\(showID)/seasons"
        case .episodes(let seasonID):
            return "/seasons/\(seasonID)/episodes"
        case .searchShows:
            return "/search/shows"
        case .searchPersons:
            return "/search/people"
        }
    }

    var method: String { "GET" }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        case .searchPersons(let query), .searchShows(let query):
            return [URLQueryItem(name: "q", value: query)]
        default:
            return nil
        }
    }
}
