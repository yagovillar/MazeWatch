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
    func didUpdateState(_ state: SearchState)
}

enum SearchState {
    case idle
    case loading
    case results([SearchResult])
    case error(MazeError)
}

class SearchShowsViewModel: SearchViewModelProtocol {

    weak var coordinatorDelegate: SearchCoordinatorDelegate?
    weak var delegate: SearchViewModelDelegate?
    private let service: MazeServiceProtocol
    private let resultsModel: SearchModel
    private var currentState: SearchState = .idle {
        didSet {
            delegate?.didUpdateState(currentState)
        }
    }

    init(service: MazeServiceProtocol,
         resultsModel: SearchModel = SearchModel()) {
        self.service = service
        self.resultsModel = resultsModel
    }

    func search(query: String) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            clearResults()
            return
        }
        
        currentState = .loading
        
        Task {
            do {
                let results = try await service.search(query: query)
                if results.isEmpty {
                    GlobalErrorHandler.shared.showError("No results found")
                    currentState = .error(.noResults)
                } else {
                    resultsModel.updateDataBase(with: results)
                    currentState = .results(results)
                }
            } catch {
                GlobalErrorHandler.shared.showError(error.localizedDescription)
                currentState = .error(.searchFailed(error))
            }
        }
    }
    
    func clearResults() {
        resultsModel.clearDataBase()
        currentState = .idle
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
