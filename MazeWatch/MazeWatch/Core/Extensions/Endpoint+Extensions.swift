//
//  Endpoint+Extensions.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation

extension Endpoint {
    var urlRequest: URLRequest? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }
}
