//
//  HomeListViewModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation
protocol HomeListCoordinatorDelegate: AnyObject {
    func didSelectShow(showId: Int)
}

protocol HomeListViewModelDelegate: AnyObject {
    func didLoadShows()
}

protocol HomeListViewModelProtocol: AnyObject {
    var delegate: HomeListViewModelDelegate? { get set }
    func fetchShows()
    func selectShow(showId: Int)
    func getShow(at index: Int) -> Show
    func getShowCount() -> Int
}

class HomeListViewModel: HomeListViewModelProtocol {

    weak var coordinatorDelegate: HomeListCoordinatorDelegate?
    var HomeListService: MazeServiceProtocol?
    var ShowList = ShowListModel()
    weak var delegate: HomeListViewModelDelegate?
    
    init(HomeListCoordinatorDelegate: HomeListCoordinatorDelegate? = nil, HomeListService: MazeServiceProtocol?) {
        self.coordinatorDelegate = HomeListCoordinatorDelegate
        self.HomeListService = HomeListService
    }
    
    func fetchShows() {
        HomeListService?.fetchShows(page: ShowList.currentPage ) { result in
                switch result {
                    case .success(let shows):
                    self.ShowList.currentPage += 1
                    self.ShowList.shows.append(contentsOf: shows)
                    self.delegate?.didLoadShows()
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
    }
    
    func selectShow(showId: Int) {
        coordinatorDelegate?.didSelectShow(showId: showId)
    }
    
    func getShow(at index: Int) -> Show {
        return ShowList.shows[index]
    }
    
    func getShowCount() -> Int {
        return ShowList.shows.count
    }
    
}
