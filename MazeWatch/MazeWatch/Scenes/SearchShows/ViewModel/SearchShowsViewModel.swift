//
//  SearchShowsViewModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

import Foundation

protocol SearchShowsCoordinatorDelegate: AnyObject {
    func didSelectShow(showId: Int)
}

protocol SearchShowsViewModelProtocol: AnyObject {
    var delegate: SearchShowsViewModelDelegate? { get set }
    func search(query: String)
    func clearResults()
    func getShowsCount() -> Int
    func getShow(at index: Int) -> Show
    func didSelectShow(at index: Int)
}

protocol SearchShowsViewModelDelegate: AnyObject {
    func didSearch()
}

class SearchShowsViewModel: SearchShowsViewModelProtocol {

    weak var coordinatorDelegate: SearchShowsCoordinatorDelegate?
    weak var delegate: SearchShowsViewModelDelegate?
    var service: MazeServiceProtocol
    let resultsModel: ShowResultsManaging


    init(coordinatorDelegate: SearchShowsCoordinatorDelegate? = nil, service: MazeServiceProtocol, resultsModel: ShowResultsManaging = SearchShowsModel()) {
        self.coordinatorDelegate = coordinatorDelegate
        self.service = service
        self.resultsModel = resultsModel
    }
    
    func search(query: String) {
        service.searchShows(query: query) { [weak self] result in
            switch result {
            case .success(let results):
                let shows = results.map { $0.show }
                self?.resultsModel.update(with: shows)
                self?.delegate?.didSearch()
            case .failure(let error):
                print("Search failed: \(error.localizedDescription)")
                self?.clearResults()
            }
        }
    }
    
    func clearResults() {
        resultsModel.clear()
        self.delegate?.didSearch()
    }
    
    func getShowsCount() -> Int {
        return self.resultsModel.count
    }
    
    func getShow(at index: Int) -> Show {
        guard let show = self.resultsModel.show(at: index) else { return Show.getEmptyShow() }
        return show
    }
    
    func didSelectShow(at index: Int) {
        coordinatorDelegate?.didSelectShow(showId: self.resultsModel.show(at: index)?.id ?? 0)
    }
}
