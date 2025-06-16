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
        let viewModel = HomeListViewModel(homeListService: service)
        viewModel.coordinatorDelegate = self
        let viewController = HomeListViewController(viewModel: viewModel)
        viewController.title = "Shows"
        navigationController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "tv"), tag: 0)
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white // cor desejada
        ]
        navigationController.viewControllers = [viewController]
    }

}

extension HomeListCoordinator: HomeListCoordinatorDelegate {
    func didSelectShow(showId: Int) {
        let model = DetailsManager()
        model.id = showId
        let viewModel = ShowDetailsViewModel(service: MazeService(), model: model)
        viewModel.coordinatorDelegate = self
        let viewController = ShowDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        navigationController.pushViewController(viewController, animated: true)
    }

    func didSelectEpisode(episode: Episode, show: ShowDetails) {
        let viewModel = EpisodeDetailsViewModel(episode: episode, show: show)
        let viewController = EpisodeDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
