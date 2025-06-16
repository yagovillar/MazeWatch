//
//  SearchShowsModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import Foundation

protocol SearchModelProtocol: AnyObject {
    var dataBaseCount: Int { get }
    func getItem(at index: Int) -> SearchResult
    func updateDataBase(data: [SearchResult])
    func clearDataBase()
}

final class SearchModel: SearchModelProtocol {

    private var _dataBase: [SearchResult]?

    var dataBase: [SearchResult]? {
        get { _dataBase }
        set {
            _dataBase = newValue?.sorted { $0.score > $1.score }
        }
    }

    var dataBaseCount: Int {
        return dataBase?.count ?? 0
    }

    init(dataBase: [SearchResult]? = nil) {
        self.dataBase = dataBase
    }

    func getItem(at index: Int) -> SearchResult {
        guard let dataBase = dataBase else {
            fatalError("No dataBase")
        }
        return dataBase[index]
    }

    func clearDataBase() {
        self.dataBase = nil
    }

    func updateDataBase(data: [SearchResult]) {
        self.dataBase = data
    }
}
