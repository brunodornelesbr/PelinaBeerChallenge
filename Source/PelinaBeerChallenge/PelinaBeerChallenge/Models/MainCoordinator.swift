//
//  MainCoordinator.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

class MainCoordinator {
    var bestMoviesCoordinator : Coordinator
    var controller: UITabBarController
    
    var coordinators: [Coordinator] {
        return [bestMoviesCoordinator]
    }
    
     init(controller: UITabBarController) {
        self.controller = controller
        bestMoviesCoordinator = BestMoviesCoordinator(navigationController: UINavigationController())
        bestMoviesCoordinator.start()
        var controllers : [UIViewController] = []
        let bestMoviesRootViewController = bestMoviesCoordinator.navigationController
        bestMoviesRootViewController.tabBarItem = UITabBarItem(title: "Best movies", image: #imageLiteral(resourceName: "baseline_local_movies_black_24pt"), tag: 0)
        controllers.append(bestMoviesRootViewController)
        
        controller.viewControllers = controllers
        
    }
    
    func start() {
        
    }
    

}
