//
//  MazeError.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation

struct MazeErrorResponse: Decodable {
    let name: String
    let message: String
    let code: Int
    let status: Int?
    let previous: PreviousError?

    struct PreviousError: Decodable {
        let name: String
        let message: String
        let code: Int
    }
}

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int, message: String)
    case noData
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .serverError(_, let message):
            return message
        case .noData:
            return "No data received."
        case .decodingError:
            return "Failed to decode data."
        }
    }
}
