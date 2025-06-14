//
//  CoordinatorProtocol.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

import UIKit

protocol Coordinator {

  var navigationController: UINavigationController { get set }
  
  func start()

}
