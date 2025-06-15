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

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int, message: String)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request could not be completed due to an invalid URL."
        case .noData:
            return "No data was received from the server."
        case .decodingError:
            return "We were unable to process the data received."
        case .serverError(_, let message):
            return message
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
}
