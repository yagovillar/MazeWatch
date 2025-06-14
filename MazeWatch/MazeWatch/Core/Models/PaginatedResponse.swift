//
//  PaginatedResponse.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    let page: Int
    let pageSize: Int
    let totalItems: Int?
    let totalPages: Int?
    let items: [T]
}
