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
    private let tabBarController = UITabBarController()

    private let homeListCoordinator: Coordinator

    init(window: UIWindow) {
        self.window = window
        self.homeListCoordinator = HomeListCoordinator()
    }

    func start() {
        homeListCoordinator.start()

        tabBarController.viewControllers = [
            homeListCoordinator.navigationController,
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
