//
//  HomeListCoordinator.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import UIKit

class HomeListCoordinator: Coordinator {
  
    var navigationController = UINavigationController()

    func start() {
        let service = MazeService()
        let viewModel = HomeListViewModel(HomeListService: service)
        let viewController = HomeListViewController(ViewModel: viewModel)
        viewController.title = "Shows"
        navigationController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "tv"), tag: 0)
        navigationController.viewControllers = [viewController]
    }

}

extension HomeListCoordinator: HomeListCoordinatorDelegate {
    func didSelectShow(showId: Int) {
        // navigate to show page
    }
}
