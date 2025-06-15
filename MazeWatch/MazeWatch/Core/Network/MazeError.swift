//
//  MazeError.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation

enum MazeError: Error {
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case searchFailed(Error)
    case noResults
    case serverError(Int, String)
}

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
