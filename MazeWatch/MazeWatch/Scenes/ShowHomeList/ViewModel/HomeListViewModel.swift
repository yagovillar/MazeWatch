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
    var homeListService: MazeServiceProtocol?
    var showList = ShowListModel()
    weak var delegate: HomeListViewModelDelegate?

    init(homeListCoordinatorDelegate: HomeListCoordinatorDelegate? = nil, homeListService: MazeServiceProtocol?) {
        self.coordinatorDelegate = homeListCoordinatorDelegate
        self.homeListService = homeListService
    }

    func fetchShows() {
        homeListService?.fetchShows(page: showList.currentPage ) { result in
                switch result {
                case .success(let shows):
                    self.showList.currentPage += 1
                    self.showList.shows.append(contentsOf: shows)
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
        return showList.shows[index]
    }

    func getShowCount() -> Int {
        return showList.shows.count
    }

}
