//
//  AppCoordinator.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow

    private let homeListCoordinator: Coordinator
    private let searchShowsCoordinator: Coordinator

    init(window: UIWindow) {
        self.window = window
        self.homeListCoordinator = HomeListCoordinator()
        self.searchShowsCoordinator = SearchShowsCoordinator()
    }

    func start() {
        homeListCoordinator.start()
        searchShowsCoordinator.start()
        window.rootViewController = getTabBarController()
        window.makeKeyAndVisible()
    }

    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        tabBarController.tabBar.layer.cornerRadius = 20
        tabBarController.tabBar.layer.masksToBounds = true
        tabBarController.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .darkGray  // ou a cor que quiser

            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBarController.tabBar.barTintColor = .fill
            tabBarController.tabBar.isTranslucent = true
        }
        tabBarController.tabBar.backgroundColor = .fill

        tabBarController.viewControllers = [
            homeListCoordinator.navigationController,
            searchShowsCoordinator.navigationController
        ]
        return tabBarController
    }
}
