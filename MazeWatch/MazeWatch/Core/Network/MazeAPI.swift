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
}

extension MazeAPI: Endpoint {
    var baseURL: String { "https://api.tvmaze.com" }

    var path: String {
        switch self {
        case .list: return "/shows"
        case .detail(let id): return "/shows/\(id)"
        case .seasons(let showID): return "/shows/\(showID)/seasons"
        case .episodes(let seasonID): return "/seasons/\(seasonID)/episodes"
        }
    }

    var method: String { "GET" }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        default:
            return nil
        }
    }
}
