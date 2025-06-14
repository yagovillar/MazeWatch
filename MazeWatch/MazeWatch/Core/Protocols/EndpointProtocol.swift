//
//  Endpoint.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
}

