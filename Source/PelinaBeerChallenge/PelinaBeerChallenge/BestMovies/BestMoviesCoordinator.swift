//
//  BestMoviesCoordinator.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

class BestMoviesCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
        let vc = instantiateInitialVCFromStoryboard(storyboardName: "BestMovies") as! BestMoviesViewController
        let network = NetworkHandlerImpl()
        let bestMoviesNetwork = BestMoviesNetworkImpl(networkHandler: network)
        let viewModel = BestMoviesViewModel(network: bestMoviesNetwork)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: false)
        
    }
    

}
