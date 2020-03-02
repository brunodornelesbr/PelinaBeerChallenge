//
//  BestMoviesCoordinator.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

class MoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = instantiateInitialVCFromStoryboard(storyboardName: "BestMovies") as! BestMoviesViewController
        let network = NetworkHandlerImpl()
        let bestMoviesNetwork = BestMoviesNetworkImpl(networkHandler: network)
        let storageManager = FavoriteStorageManagerImpl()
        let viewModel = BestMoviesViewModel(network: bestMoviesNetwork, favoriteManager: FavoriteManager(storageManager: storageManager), coordinator: self)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(movie : Movie) {
        let vc = instantiateInitialVCFromStoryboard(storyboardName: "DetailsMovie") as! DetailsMovieViewController
        let viewModel = DetailMovieViewModel(movie: movie)
        vc.model = viewModel
        navigationController.pushViewController(vc, animated: true)
    }

}
