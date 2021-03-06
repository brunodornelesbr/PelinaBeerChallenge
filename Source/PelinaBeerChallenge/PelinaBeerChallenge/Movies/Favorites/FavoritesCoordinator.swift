//
//  FavoritesCoordinator.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 02/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

class FavoritesCoordinator: MoviesCoordinator {
    override func start() {
        let vc = instantiateInitialVCFromStoryboard(storyboardName: "BestMovies") as! BestMoviesViewController
        vc.title = "Favorites"
        let storageManager = FavoriteStorageManagerImpl()
        let favoriteManager = FavoriteManager(storageManager: storageManager)
        let bestMoviesNetwork = FavoritesNetwork(favoriteManager: favoriteManager)
        let viewModel = BestMoviesViewModel(network: bestMoviesNetwork, favoriteManager: favoriteManager, coordinator: self )
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
