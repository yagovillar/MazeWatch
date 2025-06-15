//
//  HomeListViewModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation
// Called by ViewModel to inform Coordinator about navigation actions
protocol HomeListCoordinatorDelegate: AnyObject {
    func didSelectShow(showId: Int)
}
// Called by ViewModel to inform ViewController about data changes
protocol HomeListViewModelDelegate: AnyObject {
    func didLoadShows()
}
// Interface to be used by ViewController, enforcing SOLID principles
protocol HomeListViewModelProtocol: AnyObject {
    var delegate: HomeListViewModelDelegate? { get set }
    func fetchShows()
    func selectShow(showId: Int)
    func getShow(at index: Int) -> Show
    func getShowCount() -> Int
}

class HomeListViewModel: HomeListViewModelProtocol {

    weak var coordinatorDelegate: HomeListCoordinatorDelegate?
    var service: MazeServiceProtocol?
    var showList = ShowListModel()
    weak var delegate: HomeListViewModelDelegate?

    init(homeListCoordinatorDelegate: HomeListCoordinatorDelegate? = nil, homeListService: MazeServiceProtocol?) {
        self.coordinatorDelegate = homeListCoordinatorDelegate
        self.service = homeListService
    }

    func fetchShows() {
        Task {
            do {
                let shows = try await service?.fetchShows(page: showList.currentPage)
                showList.currentPage += 1
                showList.shows.append(contentsOf: shows ?? [])
                delegate?.didLoadShows()
            } catch {
                GlobalErrorHandler.shared.showError(error.localizedDescription)
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
