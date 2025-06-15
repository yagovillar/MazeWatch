//
//  SearchShowsViewModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

import Foundation

protocol SearchCoordinatorDelegate: AnyObject {
    func didSelectShow(showId: Int)
}

protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    func search(query: String)
    func clearResults()
    func getItensCount() -> Int
    func getItem(at index: Int) -> SearchResult
    func didSelect(at index: Int)
}

protocol SearchViewModelDelegate: AnyObject {
    func didSearch()
}

class SearchShowsViewModel: SearchViewModelProtocol {

    weak var coordinatorDelegate: SearchCoordinatorDelegate?
    weak var delegate: SearchViewModelDelegate?
    var service: MazeServiceProtocol
    let resultsModel: SearchModel

    init(service: MazeServiceProtocol,
         resultsModel: SearchModel = SearchModel()) {
        self.service = service
        self.resultsModel = resultsModel
    }

    func search(query: String) {
        Task {
            do {
                let results: [SearchResult] = try await self.service.search(query: query)
                self.resultsModel.updateDataBase(data: results)
                self.delegate?.didSearch()
            } catch {
                self.clearResults()
                GlobalErrorHandler.shared.showError(error.localizedDescription)
            }
        }
    }
    
    func clearResults() {
        resultsModel.clearDataBase()
        delegate?.didSearch()
    }

    func getItensCount() -> Int {
        return resultsModel.dataBaseCount
    }

    func getItem(at index: Int) -> SearchResult {
        return resultsModel.getItem(at: index)
    }

    func didSelect(at index: Int) {
        let item = resultsModel.getItem(at: index)
        switch item.type {
        case .person:
            break // nav to details
        case .show:
            break// nav to details
        }
    }
}
