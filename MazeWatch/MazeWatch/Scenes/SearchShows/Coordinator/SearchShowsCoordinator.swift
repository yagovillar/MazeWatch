//
//  SearchShowsCoordinator.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import UIKit

class SearchShowsCoordinator: Coordinator {

    var navigationController = UINavigationController()

    func start() {
        let service = MazeService()
        let viewModel = SearchShowsViewModel(service: service)
        viewModel.coordinatorDelegate = self
        let viewController = SearchShowsViewController(viewModel: viewModel)
        viewController.title = "Search"
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white // cor desejada
        ]
        navigationController.viewControllers = [viewController]
    }

}

extension SearchShowsCoordinator: SearchShowsCoordinatorDelegate {
    func didSelectShow(showId: Int) {
        // navigate to show page
    }
}
