//
//  Episodes.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

struct Episode: Codable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let type: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let rating: Rating?
    let image: ShowImage?
    let summary: String?
}
