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

protocol HomeListViewModelProtocol: AnyObject {
    func fetchShows()
    func selectShow(showId: Int)
    func getShow(at index: Int) -> Show
    func getShowCount() -> Int
}

class HomeListViewModel: HomeListViewModelProtocol {

    weak var HomeListCoordinatorDelegate: HomeListCoordinatorDelegate?
    var HomeListService: MazeServiceProtocol?
    var ShowList = ShowListModel()
    
    init(HomeListCoordinatorDelegate: HomeListCoordinatorDelegate? = nil, HomeListService: MazeServiceProtocol?) {
        self.HomeListCoordinatorDelegate = HomeListCoordinatorDelegate
        self.HomeListService = HomeListService
    }
    
    func fetchShows() {
        HomeListService?.fetchShows(page: ShowList.currentPage ) { result in
                switch result {
                    case .success(let shows):
                    self.ShowList.currentPage += 1
                    self.ShowList.shows.append(contentsOf: shows)
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
    }
    
    func selectShow(showId: Int) {
        HomeListCoordinatorDelegate?.didSelectShow(showId: showId)
    }
    
    func getShow(at index: Int) -> Show {
        return ShowList.shows[index]
    }
    
    func getShowCount() -> Int {
        return ShowList.shows.count
    }
    
}
