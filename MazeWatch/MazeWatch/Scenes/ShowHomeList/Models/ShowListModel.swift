//
//  ShowListModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import Foundation

struct ShowListModel {
    var shows: [Show] = []
    var currentPage: Int = 0
    var isLoading: Bool = false
    var hasMorePages: Bool = true
}
